import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from validate_handover import validate  # noqa: E402


class HandoverContractTests(unittest.TestCase):
    def load(self, path):
        return json.loads(path.read_text(encoding="utf-8"))

    def test_all_valid_examples_pass(self):
        paths = sorted((ROOT / "examples" / "valid").glob("*.json"))
        self.assertGreaterEqual(len(paths), 5)
        for path in paths:
            with self.subTest(path=path.name):
                self.assertEqual(validate(self.load(path)), [])

    def test_all_invalid_examples_fail(self):
        paths = sorted((ROOT / "examples" / "invalid").glob("*.json"))
        self.assertGreaterEqual(len(paths), 3)
        for path in paths:
            with self.subTest(path=path.name):
                self.assertTrue(validate(self.load(path)))

    def test_supported_assertion_requires_evidence(self):
        record = self.load(ROOT / "examples" / "valid" / "01-supported-progress.json")
        record["assertions"][0]["evidence_refs"] = []
        self.assertTrue(any("requires evidence" in error for error in validate(record)))

    def test_conflicting_assertion_requires_two_sources(self):
        record = self.load(ROOT / "examples" / "valid" / "03-conflicting-evidence.json")
        record["assertions"][0]["evidence_refs"] = record["assertions"][0]["evidence_refs"][:1]
        self.assertTrue(any("at least two" in error for error in validate(record)))

    def test_evidence_complete_rejects_pending_assertion(self):
        record = self.load(ROOT / "examples" / "valid" / "01-supported-progress.json")
        record["work_front"]["overall_state"] = "evidence_complete"
        record["assertions"][0]["evidence_disposition"] = "pending"
        self.assertTrue(any("incomplete assertions" in error for error in validate(record)))

    def test_authority_phrase_is_rejected(self):
        record = self.load(ROOT / "examples" / "valid" / "05-paused-with-blocker.json")
        record["incoming_view"]["headline"] = "Area safe to work"
        self.assertTrue(any("forbidden phrase" in error for error in validate(record)))


if __name__ == "__main__":
    unittest.main()
