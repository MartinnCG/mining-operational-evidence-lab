# Case 002 — Rolleston DL01

> **Case status:** `ACTIVE_LONGITUDINAL`  
> **Completed evidence unit:** `SWING-001 — DOCUMENTED`  
> **Case mode:** longitudinal; completed swings only  
> **Publication mode:** sanitized personal experience plus later synthetic modelling  
> **Authority:** no operational, safety, permit, electrical, rigging, engineering, or statutory authority is claimed

## 1. Case identity

| Field | Value | Evidence class |
|---|---|---|
| Case ID | `CASE-002` | Repository-owned |
| Public context | Rolleston DL01, Queensland | `PUBLIC_CONTEXT` + `PERSONAL_EXPERIENCE` |
| Employer | Richglen | `PERSONAL_EXPERIENCE` + private roster support |
| Role | Trade Assistant | `PERSONAL_EXPERIENCE` + private roster support |
| Current evidence period | First completed swing, September 2026 | `PERSONAL_EXPERIENCE` + private roster support |
| Case maturity | `ACTIVE_LONGITUDINAL` | Repository-owned |

The case remains open for future completed swings. No current or future live work status is published.

## 2. Public-context source register

| Source | Fact supported | Checked |
|---|---|---|
| [Glencore Australia — Current operations](https://www.glencore.com.au/operations-and-projects/coal/current-operations) | Rolleston Open Cut is publicly identified as an operation | 2026-09-19 |
| [MJM Developments — Dragline Cab and Crib Upgrades](https://www.mjm-developments.com.au/our-projects1/project-one-ephnc-m6eds) | The identifier “DL01 — Rolleston” appears on a public contractor project page | 2026-09-19 |

These sources establish naming context only. They do not verify Martin's duties, shutdown scope, work fronts, asset condition, or operational observations.

## 3. Swing register

| Swing | Mobilisation | Worked shifts | Demobilisation | Status |
|---|---:|---:|---:|---|
| `SWING-001` | 2026-09-06 | 5 day shifts + 5 night shifts | 2026-09-18 | `DOCUMENTED` |

### Shift pattern

| Block | Dates | Hours | Count |
|---|---|---|---:|
| Day shift | 07–11 September 2026 | 06:30–18:30 | 5 |
| Day-to-night transition | 12 September 2026 | first night commenced at 18:30 | — |
| Night shift | starts 12–16 September 2026 | 18:30–06:30 | 5 |
| Total | — | 120 scheduled hours | 10 |

A private roster screenshot was reviewed as supporting evidence and is not published because it identifies other personnel.

## 4. Swing 001 experience summary

Martin worked as a Trade Assistant, primarily supporting one boilermaker per shift during a broad DL01 shutdown campaign.

The documented workstreams are:

1. **Initial setup:** physical assistance to electricians with generators, temporary leads, and welding-equipment supply arrangements. Martin transported and uncoiled cables but performed no electrical connections.
2. **Walking-shoe and girder support:** removal and preparation of plate material, cleaning, measuring or marking, edge preparation, manual handling, positioning, equipment setup, and consumable readiness.
3. **Machinery-house work:** support during removal of small welded plate segments around the cylindrical cable-reel drum. The formal component terminology is not independently verified.
4. **Minor work fronts:** limited guardrail-related assistance and preparation of small support pieces or cradles for welded covers.
5. **Hot-work support:** fire watch during welding, grinding, oxy-cutting, and gouging, using an extinguisher and water spray while monitoring for ignition and changing conditions.
6. **Crack-repair support:** work-front readiness while the boilermaker used gouging to remove defective material before welding.
7. **Night-shift continuity:** sustained plate and girder preparation for walking-shoe work across five night shifts.

Martin occasionally used an angle grinder when specifically permitted and directed. He did not weld, make electrical connections, operate oxy-cutting or gouging equipment, control crane lifts, confirm isolations, approve permits, or enter confined spaces.

The complete ten-shift reconstruction is in [`case-record.yaml`](case-record.yaml).

## 5. Work areas and interfaces

| Area or interface | Sanitized participation |
|---|---|
| Walking shoes | Girder and plate preparation support |
| Boilermaker bay | Equipment, consumable, and material readiness |
| Machinery house | Cable-reel drum plate-removal support |
| Deck and access areas | General setup and a minor guardrail-related task |
| Electrical setup interface | Physical cable and generator setup assistance only |
| Crane interface | Remained under assigned controls; riggers or spotters controlled lifts |
| Confined spaces | No entry; required authorization was not held |

## 6. Safety and coordination context

The recurring control vocabulary Martin encountered included:

- pre-starts and smaller work-group planning discussions;
- Work Area Familiarisation;
- JSAs, permits, and SLAM;
- barricading and access control;
- isolation and lockout-tagout awareness;
- fire-watch positioning and readiness;
- exclusion-zone awareness around interacting equipment.

These are experience statements, not evidence that Martin issued, approved, verified, or controlled those systems.

## 7. Operational learning

### Conditions that enabled progress

- The temporary camp and support layout were organised around the dragline.
- A nearby store and storeperson improved access to consumables and routine resources.
- The hierarchy between superintendents, supervisors, trades, and Trade Assistants supported direct communication.
- Small task discussions after pre-start clarified immediate work expectations.

### Dependencies and waits

- Some work required supervisor or higher-level authorization before continuation.
- Crane movements or interacting activities could control access to the work front.
- Task and worker allocation could change as priorities evolved across shifts.
- Essential shared tools were not always returned promptly to the store.

### Handover practice

Work was generally advanced as far as practical within the shift. The work area and tools were then cleaned and organised for continuation. Formal handover content remained the responsibility of supervisors and senior personnel.

### Improvement hypotheses

- strengthen general housekeeping consistency;
- improve barricading and tag completeness where required;
- make essential shared-tool return and availability more visible.

These are personal improvement hypotheses, not findings of non-compliance or criticism of Rolleston, Richglen, or another party.

## 8. Professional development

Across Swing 001, Martin developed:

- stronger familiarity with dragline layout and working rhythm;
- safer positioning around hot work, lifting interfaces, moving equipment, and restricted access;
- better anticipation of tools, consumables, materials, and work-front needs;
- practical familiarity with walking-shoe, girder, machinery-house, deck, and plate-preparation activities;
- clearer communication with boilermakers and supervisors;
- discipline in maintaining competency boundaries, particularly electrical work and confined-space entry;
- experience transitioning from day shift to night shift within one swing.

This is evidence of field learning, not a formal trade competency assessment.

## 9. Analytical question

> Can a longitudinal shutdown record distinguish completed work, prepared work, authorization waits, interacting-activity blockers, shared-tool availability, and shift-transition uncertainty without reproducing a live operational record?

The question is motivated by personal experience. It does not assert that Rolleston DL01 has a defective process.

## 10. Company-value hypotheses

| Information friction | Synthetic test candidate | Potential decision supported |
|---|---|---|
| Tools or consumables are unavailable or not returned | Explicit resource state, owner, location, and next action | Which work front requires resource follow-up? |
| Work waits on authorization | Separate `WAITING_AUTHORIZATION` from technical readiness | Why is the task not progressing? |
| Crane or interacting work controls access | Model external dependency and release state | When can the work front safely be reconsidered? |
| Prepared work is confused with completed work | Separate prepared, in-progress, and evidence-supported completion | What can the incoming shift rely on? |
| Day/night transition loses context | Record bounded handover state without copying live site records | What needs clarification at shift change? |

No realized saving, productivity improvement, safety benefit, or employer endorsement is claimed.

## 11. Evidence treatment

| Claim type | Public treatment |
|---|---|
| Dates, role, employer, and shift pattern supported by private roster | Published; roster withheld |
| Directly recalled participation | Published with role-appropriate verbs |
| Confirmed work block with uncertain daily allocation | Published as reconstructed sequence |
| Generic safety-control vocabulary | Published without permit or isolation authority |
| Uncertain component terminology | Described functionally with visible limitation |
| Contextual inference | Excluded from factual claims |
| Live or future work status | Not published |

See [`evidence-boundaries.md`](evidence-boundaries.md) for the controlling interpretation rules.

## 12. Evidence artifacts

- [x] Swing 001 retrospective completed
- [x] Private roster evidence reviewed and withheld
- [x] Ten shifts reconstructed and evidence-labelled
- [x] Employer, role, dates, and workstream scope recorded
- [x] Machine-readable claim register
- [x] Evidence, competency, and authority boundary
- [x] Initial longitudinal design hypotheses
- [ ] Case-specific synthetic scenario manifest
- [ ] Reproducible comparison with Case 001
- [ ] Derived analysis and findings
- [ ] Later completed swings

## 13. Findings and limitations

Swing 001 is documented as professional evidence but has not yet produced synthetic analytical findings.

Limitations:

- task details are retrospective self-report;
- the private roster supports scheduling facts, not daily activities;
- some day-level allocation is reconstructed from confirmed work blocks;
- component terminology is intentionally bounded where uncertain;
- the account cannot establish asset condition, repair quality, completion, compliance, or shutdown performance;
- the project is independent and is not commissioned, reviewed, approved, or endorsed by the site owner, operator, employer, or contractors.

## 14. Change log

| Date | Change | Maturity transition |
|---|---|---|
| 2026-09-19 | Context-only longitudinal case registered | — → `REGISTERED` |
| 2026-09-20 | Swing 001 schedule, ten-shift reconstruction, workstreams, boundaries, and hypotheses documented | `REGISTERED` → `ACTIVE_LONGITUDINAL` |
