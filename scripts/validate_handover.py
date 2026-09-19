#!/usr/bin/env python3
"""Validate synthetic shutdown handover records with no third-party dependencies."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path
from typing import Any

REQUIRED_TOP = {
    "contract_version", "record_id", "scenario_id", "synthetic", "generated_at",
    "handover_at", "shift_window", "work_front", "incoming_view", "assertions",
    "evidence_items", "interruptions", "authority_boundary", "provenance", "limitations",
}
STATES = {"not_started", "in_progress", "paused", "reported_complete", "evidence_complete", "unknown"}
DISPOSITIONS = {"supported", "pending", "conflicting", "missing", "not_applicable"}
PRIORITIES = {"none", "blocker", "evidence_gap", "ownership_gap", "state_change", "conflict", "unknown"}
FORBIDDEN_PHRASES = {
    "safe to work", "approved to work", "authorized to proceed",
    "authorised to proceed", "isolation confirmed", "permit approved", "ready to work",
}
BOUNDARY_STATEMENT = "Evidence record only. Follow site procedures and competent-person authority."


def parse_time(value: Any, path: str, errors: list[str]) -> datetime | None:
    if not isinstance(value, str):
        errors.append(f"{path}: expected ISO-8601 string")
        return None
    try:
        return datetime.fromisoformat(value.replace("Z", "+00:00"))
    except ValueError:
        errors.append(f"{path}: invalid ISO-8601 timestamp")
        return None


def strings(value: Any):
    if isinstance(value, str):
        yield value
    elif isinstance(value, dict):
        for item in value.values():
            yield from strings(item)
    elif isinstance(value, list):
        for item in value:
            yield from strings(item)


def validate(record: Any) -> list[str]:
    errors: list[str] = []
    if not isinstance(record, dict):
        return ["root: expected object"]

    missing = sorted(REQUIRED_TOP - set(record))
    if missing:
        errors.append(f"root: missing fields {missing}")
        return errors

    if record["contract_version"] != "1.0.0":
        errors.append("contract_version: expected 1.0.0")
    if record["synthetic"] is not True:
        errors.append("synthetic: must be true")
    if not str(record["record_id"]).startswith("HANDOVER-SYN-"):
        errors.append("record_id: must start HANDOVER-SYN-")
    if not str(record["scenario_id"]).startswith("SCENARIO-SYN-"):
        errors.append("scenario_id: must start SCENARIO-SYN-")

    provenance = record.get("provenance", {})
    if provenance.get("source_mode") != "synthetic":
        errors.append("provenance.source_mode: must be synthetic")
    if provenance.get("no_real_site_data") is not True:
        errors.append("provenance.no_real_site_data: must be true")
    if not isinstance(provenance.get("seed"), int) or provenance.get("seed", -1) < 0:
        errors.append("provenance.seed: expected non-negative integer")

    work_front = record.get("work_front", {})
    overall = work_front.get("overall_state")
    if overall not in STATES:
        errors.append("work_front.overall_state: invalid state")
    if not str(work_front.get("id", "")).startswith("WF-SYN-"):
        errors.append("work_front.id: must start WF-SYN-")

    incoming = record.get("incoming_view", {})
    if incoming.get("priority_condition") not in PRIORITIES:
        errors.append("incoming_view.priority_condition: invalid value")
    if not incoming.get("headline"):
        errors.append("incoming_view.headline: required")
    for index, action in enumerate(incoming.get("next_actions", [])):
        if not all(action.get(k) for k in ("action_id", "description", "owner_role", "timing")):
            errors.append(f"incoming_view.next_actions[{index}]: incomplete action")

    evidence_items = record.get("evidence_items", [])
    evidence_ids: set[str] = set()
    for index, item in enumerate(evidence_items):
        evidence_id = item.get("evidence_id")
        if not isinstance(evidence_id, str) or not evidence_id.startswith("EV-SYN-"):
            errors.append(f"evidence_items[{index}].evidence_id: invalid")
        elif evidence_id in evidence_ids:
            errors.append(f"evidence_items[{index}].evidence_id: duplicate")
        else:
            evidence_ids.add(evidence_id)
        if item.get("synthetic") is not True:
            errors.append(f"evidence_items[{index}].synthetic: must be true")

    assertions = record.get("assertions", [])
    if not assertions:
        errors.append("assertions: at least one required")
    assertion_ids: set[str] = set()
    for index, assertion in enumerate(assertions):
        prefix = f"assertions[{index}]"
        assertion_id = assertion.get("assertion_id")
        if not isinstance(assertion_id, str) or not assertion_id.startswith("AST-SYN-"):
            errors.append(f"{prefix}.assertion_id: invalid")
        elif assertion_id in assertion_ids:
            errors.append(f"{prefix}.assertion_id: duplicate")
        else:
            assertion_ids.add(assertion_id)

        if assertion.get("reported_state") not in STATES:
            errors.append(f"{prefix}.reported_state: invalid")
        disposition = assertion.get("evidence_disposition")
        if disposition not in DISPOSITIONS:
            errors.append(f"{prefix}.evidence_disposition: invalid")
        refs = assertion.get("evidence_refs")
        if not isinstance(refs, list):
            errors.append(f"{prefix}.evidence_refs: expected array")
            refs = []
        unresolved = sorted(set(refs) - evidence_ids)
        if unresolved:
            errors.append(f"{prefix}.evidence_refs: unresolved {unresolved}")
        if disposition == "supported" and not refs:
            errors.append(f"{prefix}: supported assertion requires evidence")
        if disposition == "conflicting" and len(set(refs)) < 2:
            errors.append(f"{prefix}: conflicting assertion requires at least two evidence items")
        if not assertion.get("limitations"):
            errors.append(f"{prefix}.limitations: at least one required")
        parse_time(assertion.get("observed_at"), f"{prefix}.observed_at", errors)

    if overall == "evidence_complete":
        incomplete = [
            a.get("assertion_id", "?") for a in assertions
            if a.get("evidence_disposition") not in {"supported", "not_applicable"}
        ]
        if incomplete:
            errors.append(f"work_front.overall_state: evidence_complete has incomplete assertions {incomplete}")

    boundary = record.get("authority_boundary", {})
    for key in ("authorizes_work", "confirms_isolation", "approves_permit", "declares_safe"):
        if boundary.get(key) is not False:
            errors.append(f"authority_boundary.{key}: must be false")
    if boundary.get("statement") != BOUNDARY_STATEMENT:
        errors.append("authority_boundary.statement: unexpected statement")

    lower_strings = [text.lower() for text in strings(record)]
    for phrase in sorted(FORBIDDEN_PHRASES):
        if any(phrase in text for text in lower_strings):
            errors.append(f"authority claim: forbidden phrase '{phrase}'")

    start = parse_time(record.get("shift_window", {}).get("start"), "shift_window.start", errors)
    end = parse_time(record.get("shift_window", {}).get("end"), "shift_window.end", errors)
    handover = parse_time(record.get("handover_at"), "handover_at", errors)
    parse_time(record.get("generated_at"), "generated_at", errors)
    if start and end and start >= end:
        errors.append("shift_window: start must precede end")
    if start and end and handover and not (start <= handover <= end):
        errors.append("handover_at: must fall inside shift window")
    if not record.get("limitations"):
        errors.append("limitations: at least one required")

    return errors


def validate_path(path: Path) -> tuple[int, int]:
    files = sorted(path.rglob("*.json")) if path.is_dir() else [path]
    passed = 0
    failed = 0
    for file_path in files:
        try:
            record = json.loads(file_path.read_text(encoding="utf-8"))
            errors = validate(record)
        except (OSError, json.JSONDecodeError) as exc:
            errors = [f"read: {exc}"]
        if errors:
            failed += 1
            print(f"FAIL {file_path}")
            for error in errors:
                print(f"  - {error}")
        else:
            passed += 1
            print(f"PASS {file_path}")
    return passed, failed


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("path", type=Path)
    args = parser.parse_args()
    passed, failed = validate_path(args.path)
    print(f"RESULT passed={passed} failed={failed}")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
