# Operating Workflow

## Purpose

This workflow converts field learning into company-relevant, reproducible analytical evidence while keeping raw and live operational information outside the public repository.

The repository is not a diary. It is the controlled output of a gated process.

## Workflow

| Stage | Location | Output | Gate |
|---|---|---|---|
| 0. Private capture | Private device or approved personal system | Brief structured observation | Site-rule compliance |
| 1. End-of-swing triage | Private | Candidate recurring patterns | Recurrence and usefulness |
| 2. Sanitization | Private working copy | De-identified pattern statement | Confidentiality |
| 3. Case framing | GitHub issue | User, decision, friction, evidence, metric, boundary | Company value and testability |
| 4. Synthetic modelling | Feature branch | Fictional data, contract, or scenario | Separation and provenance |
| 5. Validation | Feature branch and CI | Tests, data-quality result, rejected assumptions | Reproducibility |
| 6. Case brief | Case folder | Finding, limitation, and decision relevance | Claims review |
| 7. Cross-case synthesis | Repository-level study | Comparable patterns across shutdowns | Comparability |

## Daily private capture

Target effort: **five to seven minutes after a shift**, when permitted and away from operational activity.

Capture one useful pattern, not a chronological account. If nothing meaningful occurred, record nothing. Commit volume and daily streaks are not objectives.

Minimum fields:

- generalized pattern category;
- one- or two-sentence observation;
- possible consequence class;
- signal available;
- signal missing or ambiguous;
- what the next role needed to understand;
- recurrence and confidence;
- sensitivity classification;
- candidate system improvement.

Completed forms remain private and are never committed.

## End-of-swing triage

At the end of a swing, review private entries and keep only patterns that are:

- recurrent or structurally important;
- about information, coordination, evidence, or decision support;
- capable of being expressed without people, blame, or event reconstruction;
- testable with fictional data;
- potentially useful to a defined operational role.

Duplicates are consolidated. Weak or unsafe observations are archived privately or deleted according to the chosen private-record policy.

## Quality gates

### Gate A — Confidentiality

Reject anything that exposes a person, crew, live state, precise operational timeline, internal record, non-public asset condition, incident, access detail, or proprietary process.

### Gate B — Company value

Reject work that cannot name an operational user, decision, information friction, and existing process it complements.

### Gate C — Testability

Reject a hypothesis if no synthetic scenario, acceptance criterion, or failure condition can test it.

### Gate D — Reproducibility

Reject a result if a clean checkout cannot reproduce or inspect the evidence chain.

### Gate E — Claims

Reject wording that converts a synthetic result into an assertion about the named operation, realised savings, safety improvement, deployment, endorsement, or authority.

## GitHub delivery pattern

1. One issue defines one question and its acceptance criteria.
2. One focused branch changes the minimum necessary artifacts.
3. Synthetic data and tests are versioned together.
4. The PR identifies evidence, company value, confidentiality, claims, and portfolio impact.
5. Merge only after the diff and evidence chain are reviewed.
6. Update the case brief only when the new evidence changes its maturity or findings.

## Public repository surface

Keep:

- architecture and definitions;
- case briefs;
- synthetic schemas and datasets;
- validation code and tests;
- metric definitions;
- reproducible outputs;
- findings, limitations, and decision briefs.

Keep out:

- completed daily forms;
- raw field notes;
- duplicated narrative;
- speculative dashboards;
- screenshots without provenance;
- large binaries without an analytical purpose;
- tools that do not serve a case question.

This constraint keeps the repository professional, navigable, and legible to a company reviewer.
