# Private Daily Capture Template

> **Do not commit completed copies of this template.**  
> Use only when permitted by site rules and never during operational activity. Do not copy from site systems, documents, radio traffic, photographs, permits, work packs, or internal records.

## Capture header

| Field | Entry |
|---|---|
| Private entry ID | |
| Case | `CASE-___` |
| Private date or shift reference | |
| Time spent completing | Target: 5–7 minutes |

## Minimum capture

| Field | Guidance | Entry |
|---|---|---|
| Pattern category | Handover, readiness, access, material, tooling, dependency, coordination, evidence, weather, or other | |
| Generalized observation | One or two sentences; facts about the information pattern, not people or blame | |
| Possible consequence | Delay, rework, uncertainty, duplicated effort, weak prioritisation, or other | |
| Signal available | What generic signal helped people understand the state? | |
| Signal missing or ambiguous | What information would have reduced uncertainty? | |
| Next-role need | What did the next role need to understand? | |
| Recurrence | First observation, repeated, or recurring | |
| Confidence | 1 low — 5 high | |
| Candidate improvement | Contract, validation, view, workflow, or metric to test later | |
| Sensitivity | `RED_PRIVATE`, `AMBER_REVIEW`, or `GREEN_CANDIDATE` | |

## Sensitivity rule

- `RED_PRIVATE`: contains identifying or operational detail; never move to the repository.
- `AMBER_REVIEW`: may contain indirect identifiers or an event reconstruction; sanitize before any further use.
- `GREEN_CANDIDATE`: generalized enough for end-of-swing triage, but still not approved for publication.

No entry moves directly from daily capture to GitHub.

## Prohibited capture

Do not record:

- names, initials, signatures, phone numbers, IDs, or crew composition;
- exact work-front, equipment-condition, defect, failure, downtime, production, or access details;
- permit, isolation, incident, inspection, JSA/JHA, work-order, or procedure content;
- copied timestamps, screenshots, photographs, maps, radio messages, or internal terminology;
- judgments about an individual's competence or conduct;
- information whose capture itself is prohibited by site or employment rules.

## End-of-swing promotion check

A pattern may become a sanitized issue candidate only if all answers are yes:

- [ ] It describes a recurring class of information friction, not a real event.
- [ ] People, exact dates, crews, assets, and live state have been removed.
- [ ] A company user and decision can be named.
- [ ] The idea can be tested with fictional data.
- [ ] Publication would not imply site performance, employer endorsement, or operational authority.
