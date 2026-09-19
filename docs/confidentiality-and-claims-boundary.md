# Confidentiality and Claims Boundary

## Publication rule

Only publish material that is:

- deliberately synthetic;
- generalized beyond any identifiable employer or site;
- derived from an open source with attribution; or
- a project-owned method, schema, test, or analysis.

When uncertain, do not publish.

## Prohibited content

Do not commit:

- employer, contractor, client, mine, pit, plant, camp, or asset identities;
- exact dates, rosters, crew compositions, work locations, or travel patterns;
- real work orders, permits, isolations, JHAs/JSAs, procedures, checklists, incident details, production figures, maintenance histories, or screenshots;
- photographs, maps, radio traffic, names, signatures, IDs, contact information, or internal terminology that can identify an operation;
- credentials, access paths, internal URLs, proprietary formats, or security details;
- reconstructed combinations of facts that could re-identify a site or event.

## Allowed abstractions

Examples may use:

- fictional sites such as `SITE-SYN-01`;
- fictional work fronts and assets;
- shifted or generated timestamps;
- invented role identifiers;
- synthetic interruptions and evidence gaps;
- public geospatial data with documented provenance;
- generic terminology common to the industry.

Synthetic content must be marked in both human-readable documentation and machine-readable records.

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

1. Is every example synthetic or openly sourced?
2. Could the combination of details identify an employer, site, person, asset, or event?
3. Does any wording imply deployment, approval, or authority that is not evidenced?
4. Are limitations and uncertainty visible?
5. Does the change alter another portfolio repository's contract or public narrative?

If any answer is unsafe or unclear, stop and sanitize the change.
