# Field Learning Protocol

## Objective

Convert experience gained during a year of Queensland mining and shutdown work into reusable systems knowledge without copying confidential information or pretending to hold operational authority.

## Capture model

Do not record raw site details in this repository. After a shift or swing, capture only a sanitized learning unit:

| Field | Question |
|---|---|
| Pattern | What recurring coordination or evidence problem was observed? |
| Consequence | What confusion, delay, rework, or uncertainty can the pattern create? |
| Current signal | What generic evidence normally helps people understand the state? |
| Missing signal | What information is often absent, late, ambiguous, or disconnected? |
| Handover need | What must the next role understand? |
| System hypothesis | What contract, validation, or interface might help? |
| Boundary | What must remain under site, safety, statutory, or competent-person authority? |
| Sanitization check | Could this identify a real employer, site, person, asset, or event? |

## Abstraction pipeline

1. **Observe privately:** learn from normal work within site rules.
2. **Delay and detach:** do not publish during the event; remove identifying context.
3. **Generalize:** describe a class of coordination problem, not a story about a specific event.
4. **Synthesize:** generate fictional actors, timestamps, assets, evidence, and outcomes.
5. **Model:** express the pattern as a contract, state transition, test, or failure mode.
6. **Challenge:** include missing evidence, contradictory events, late updates, and unsupported claims.
7. **Document:** record what the synthetic test demonstrates and what it does not.
8. **Synchronize:** assess impact on Operational Systems Design and connected repositories.

## Good transformation

Private observation:

> A work area changed state, but different people relied on different evidence at handover.

Publishable abstraction:

> Model a synthetic work front where status assertions conflict, evidence timestamps differ, and ownership transfers between fictional roles.

## Bad transformation

> On a named date, a named crew at a recognizable asset failed to attach a real permit before night shift.

Changing names alone is not sufficient sanitization.

## Weekly cadence compatible with shutdown work

The cadence is outcome-based, not streak-based:

- **Field week:** privately note one generalized pattern; no GitHub activity required.
- **Room/off-swing session:** sanitize one pattern and convert it into one issue or scenario proposal.
- **Build session:** add one small evidence-bearing artifact or test.
- **Review session:** explain the architectural reason, limitation, and portfolio impact.
- **Monthly synthesis:** publish one concise learning note from completed, synthetic work.

A quiet week during a shutdown is valid. Credibility comes from coherent evidence, not commit volume.

## Definition of learning evidence

A contribution counts when it leaves at least one inspectable artifact:

- schema or contract;
- synthetic scenario;
- validation rule;
- automated test;
- architecture decision;
- failure analysis;
- reproducible result;
- limitation or rejected hypothesis.

Narrative activity without evidence does not count as a milestone.
