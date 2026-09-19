# Confidentiality and Claims Boundary

## Publication rule

Only publish material that is:

- deliberately synthetic;
- generalized so it does not expose confidential operational information;
- derived from an open source with attribution;
- a limited personal-experience claim that Martin can truthfully and lawfully make; or
- a project-owned method, schema, test, or analysis.

When uncertain, do not publish.

## Named public context

A real site or asset identifier may be used as contextual metadata only when:

1. it is independently visible in a public source;
2. that source and the exact fact it supports are recorded;
3. the identifier is not combined with sensitive or live operational detail;
4. the publication is compatible with applicable employment agreements and site policies;
5. the resulting combination cannot reasonably re-identify confidential activity.

Public availability of a name does not make associated private operational information public.

## Prohibited content

Do not commit:

- non-public employer, contractor, client, mine, pit, plant, camp, or asset identities;
- exact operational dates, real rosters, crew compositions, work locations, travel patterns, or live status;
- real work orders, permits, isolations, JHAs/JSAs, procedures, checklists, incident details, production figures, maintenance histories, or screenshots;
- photographs, radio traffic, names, signatures, IDs, contact information, or internal terminology that exposes an operation;
- non-public equipment condition, defects, downtime, failure modes, access details, or security-relevant information;
- credentials, internal URLs, proprietary formats, or security details;
- reconstructed combinations of facts that could re-identify a person, crew, event, or confidential activity.

## Allowed abstractions

Examples may use:

- publicly sourced site or asset names as context-only metadata;
- fictional work fronts and asset identifiers;
- shifted or generated timestamps;
- invented role identifiers;
- synthetic interruptions and evidence gaps;
- public geospatial data with documented provenance;
- generic terminology common to the industry.

Synthetic content must be marked in both human-readable documentation and machine-readable records.

## Evidence classes

| Class | Publication meaning |
|---|---|
| `PUBLIC_CONTEXT` | Independently public fact with source attribution |
| `PERSONAL_EXPERIENCE` | Limited, truthful first-person fact that passes confidentiality review |
| `SYNTHETIC_DATA` | Deliberately invented operational content |
| `DERIVED_ANALYSIS` | Reproducible output from declared inputs |
| `UNKNOWN` | Not evidenced and not inferred |

## Claims ladder

| Level | Permitted claim |
|---|---|
| Designed | A documented pattern or contract exists |
| Tested synthetically | Automated or manual tests passed on synthetic cases |
| Demonstrated | A reproducible public demonstration exists |
| Piloted | Requires documented authorization and genuine pilot evidence |
| Deployed | Requires verifiable production evidence and approval |

Until independently supported, this repository remains at **Designed** or **Tested synthetically**.

## Safety and authority boundary

This repository is not:

- a safety management system;
- a permit-to-work system;
- an isolation authority;
- an inspection, engineering, or statutory approval;
- a substitute for site procedures, supervision, training, competent persons, or emergency response.

Artifacts can preserve evidence about process state. They cannot authorize work or declare an area safe.

## Pre-publication test

Before every PR, answer:

1. Is each factual statement classified as public context, limited personal experience, synthetic data, derived analysis, or unknown?
2. Does every named site or asset have a source register and context-only purpose?
3. Could the combination of details identify a person, crew, live state, confidential event, or non-public condition?
4. Does any wording imply deployment, approval, competence, or authority that is not evidenced?
5. Are limitations and uncertainty visible?
6. Does the change alter another portfolio repository's contract or public narrative?

If any answer is unsafe or unclear, stop and sanitize the change.
