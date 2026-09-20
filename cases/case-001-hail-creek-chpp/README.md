# Case 001 — Hail Creek CHPP

> **Case status:** `FRAMED`  
> **Case mode:** retrospective  
> **Publication mode:** sanitized personal experience plus synthetic modelling  
> **Authority:** no operational, safety, permit, engineering, or statutory authority is claimed

## 1. Case identity

| Field | Value | Evidence class |
|---|---|---|
| Case ID | `CASE-001` | Repository-owned |
| Public context | Hail Creek CHPP, Queensland | `PUBLIC_CONTEXT` + `PERSONAL_EXPERIENCE` |
| Experience period | Nine-day shutdown during 2026; exact dates withheld | `PERSONAL_EXPERIENCE` |
| Role | Trade Assistant | `PERSONAL_EXPERIENCE` |
| Maturity | `FRAMED` | Repository-owned |

## 2. Public-context source register

| Source | Fact supported | Checked |
|---|---|---|
| [Glencore Australia — Current operations](https://www.glencore.com.au/operations-and-projects/coal/current-operations) | Hail Creek Open Cut is publicly identified as an operation | 2026-09-19 |

The public source does not verify Martin's employment, duties, shutdown dates, work fronts, or operational observations.

## 3. Limited personal-experience statement

Martin participated as a Trade Assistant in a nine-day shutdown during 2026. His work involved supporting fitters, riggers, and boilermakers across generalized maintenance activities.

The sanitized workstream categories retained for professional learning are:

- support during removal and replacement of mesh flooring sections;
- coordination support while riggers moved removed and replacement sections;
- assistance around component and pipework-related maintenance;
- work-area preparation, material and tool readiness, housekeeping, and hot-work support;
- recognition of a missing-fixings dependency before it affected the next task.

These statements describe Martin's participation at a high level. They do not establish the site's maintenance scope, equipment condition, crew performance, safety status, or shutdown outcome.

## 4. Evidence treatment

The private retrospective contains more detail than this public case. It is not committed.

| Claim type | Public treatment |
|---|---|
| Directly recalled participation | Published only at sanitized workstream level |
| Confirmed activity with uncertain daily allocation | Activity retained; day-by-day allocation withheld |
| Reconstructed sequence | Used to support private reflection, not presented as a site record |
| Contextual inference | Excluded from factual claims |
| Unknown detail | Remains unknown |

See [`case-record.yaml`](case-record.yaml) for the machine-readable claim register and [`evidence-boundaries.md`](evidence-boundaries.md) for the interpretation rules.

## 5. Sanitized analytical question

> Can a shutdown handover record distinguish reported progress, supporting evidence, material dependencies, ownership, and uncertainty without implying operational authority?

This question is motivated by personal experience but does not assert that Hail Creek CHPP had a defective process.

## 6. Generalized learning patterns

The retrospective produced three design hypotheses:

1. **Sequenced-trade visibility:** work involving multiple trades benefits from a visible dependency sequence rather than an unqualified complete/incomplete label.
2. **Material-readiness visibility:** missing fixings, tools, or consumables should appear as explicit dependencies with an owner and next action.
3. **Evidence-state separation:** reported progress should remain distinct from evidence-supported progress and from authorization to proceed.

These are transferable hypotheses for synthetic testing. They are not findings about the named site.

## 7. Company-value hypothesis

| Element | Framed hypothesis |
|---|---|
| Operational user | Incoming supervisor or shutdown coordinator |
| Decision supported | Which work front requires clarification or follow-up first? |
| Information friction | Progress, dependencies, evidence, and ownership can become difficult to distinguish during handover |
| Evidence required | State assertion, evidence reference, timestamp, blocker, owner, next action, and limitation |
| Inspectable measure | Synthetic reviewer identifies unsupported, conflicting, stale, or blocked states |
| Existing process complemented | Shift handover and shutdown coordination |

No saving, safety improvement, productivity gain, or realized operational benefit is claimed.

## 8. Model connection

Case 001 motivates the repository's [Synthetic Shutdown Handover Contract v1](../../contracts/shutdown-handover/v1/README.md). The contract uses entirely fictional actors, timestamps, work fronts, interruptions, evidence items, and outcomes.

The real retrospective supplies only the generalized design question. It is not converted into synthetic truth and is not used as a site dataset.

## 9. Publication and authority boundary

- No exact operational dates, crew identities, real work-front states, permits, isolations, drawings, work orders, photographs, or internal records are published.
- The employer identity and private daily reconstruction remain outside the repository.
- The case does not authorize work, confirm isolation, approve a permit, declare an area safe, or represent a site-approved system.
- Hail Creek CHPP is used as public context only; no endorsement or review is implied.

## 10. Evidence artifacts

- [x] Private retrospective completed and retained outside GitHub
- [x] Sanitized personal-experience statement
- [x] Machine-readable claim register
- [x] Evidence and publication boundary
- [x] Generalized design hypotheses
- [x] Synthetic handover contract linked
- [ ] Case-specific synthetic scenario manifest
- [ ] Reproducible case analysis and findings

## 11. Findings and limitations

The case is framed but has not yet produced case-specific synthetic findings. Current outputs demonstrate claim separation and problem formulation only.

Limitations:

- the source is retrospective self-reporting;
- the public version deliberately removes daily and operational detail;
- reconstructed timing cannot verify a real sequence;
- synthetic testing cannot establish actual site conditions or benefits;
- professional learning does not constitute engineering, safety, or operational authority.

## 12. Change log

| Date | Change | Maturity transition |
|---|---|---|
| 2026-09-19 | Case registered from confirmed high-level personal context | — → `REGISTERED` |
| 2026-09-20 | Sanitized retrospective, claim register, hypotheses, and contract link added | `REGISTERED` → `FRAMED` |
