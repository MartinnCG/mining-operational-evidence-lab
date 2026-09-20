# Case 001 Evidence Boundaries

## Purpose

This note defines how the Case 001 retrospective is translated into public repository claims. It protects operational truth by separating memory, reconstruction, inference, and unknown information.

## Status is not confidence

`evidence_status` describes the basis of a statement. `confidence` describes the reporter's certainty. They must not be merged.

| Evidence status | Meaning | Public rule |
|---|---|---|
| `directly_recalled` | A specific fact is personally remembered | Publish only after sanitization |
| `confirmed_activity` | The activity occurred, but some timing or technical detail is incomplete | Publish the activity; qualify or withhold the uncertain detail |
| `partially_recalled` | The core activity is remembered but its scope is incomplete | Use bounded language and visible limitations |
| `reconstructed_sequence` | Order or timing is rebuilt from confirmed facts | Do not present as an operational record |
| `contextual_inference` | A detail is plausible from domain context but not remembered | Exclude from factual claims |
| `unknown` | Available information cannot support the statement | Preserve as unknown |

## Wording controls

Use verbs that match Martin's actual role:

- `supported`, `assisted`, `prepared`, `maintained`, `helped coordinate`, `identified`, `reported`;
- use `the crew completed` when the result belonged to the crew;
- do not use `approved`, `authorized`, `certified`, `verified safe`, or `confirmed isolation`;
- do not write `Martin replaced` when the supported claim is that he assisted trades during replacement.

## Combination risk

A statement can be individually harmless but unsafe in combination. Exact dates, employer, named work fronts, crew composition, equipment identity, task sequence, and site name are therefore not published together.

## Repository rule

The private Spanish retrospective remains outside GitHub. The repository contains only:

1. limited sanitized personal-experience claims;
2. generalized design hypotheses;
3. entirely fictional operational scenarios;
4. reproducible derived analysis with declared inputs and limitations.
