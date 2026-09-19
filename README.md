# Mining Operational Evidence Lab

A public evidence-design laboratory that converts mining shutdown experience into reproducible, synthetic operational case studies.

## Purpose

This repository translates field learning from Queensland mining and shutdown environments into inspectable system-design artifacts. Its first analytical question is:

> Can a shutdown handover preserve work-front state, interruptions, ownership, evidence gaps, and next actions without claiming safety, permit, or operational authority?

The repository uses named sites only as public professional context. It does not publish real operational records.

## Audience model

This repository serves two deliberately separate audiences:

1. **Professional audience:** clients, recruiters, and companies evaluating Martin's ability to connect field experience, data science, system architecture, evidence governance, and AI.
2. **Operational persona inside a synthetic case:** an incoming supervisor who must understand a work front in under one minute.

The repository is a professional evidence asset, not a claim that any mine currently operates this system.

## Evidence model

Every published statement or artifact belongs to one explicit class:

| Class | Meaning |
|---|---|
| `PUBLIC_CONTEXT` | Independently public information with a cited source |
| `PERSONAL_EXPERIENCE` | A limited first-person fact Martin can truthfully claim |
| `SYNTHETIC_DATA` | Deliberately invented operational records used for modelling |
| `DERIVED_ANALYSIS` | Reproducible output calculated from declared inputs |
| `UNKNOWN` | Information not evidenced and therefore not inferred |

## Case register

| Case | Context | Mode | Current state |
|---|---|---|---|
| [Case 001](cases/case-001-hail-creek-chpp/README.md) | Hail Creek CHPP | Retrospective | Registered |
| [Case 002](cases/case-002-rolleston-dl01/README.md) | Rolleston DL01 | Longitudinal; publication deferred | Registered |

All cases follow the [case-study framework](docs/case-study-framework.md) and the reusable [case template](cases/_template/README.md).

## What this project is intended to prove

Through inspectable artifacts rather than unsupported biography, the repository demonstrates an ability to:

- recognize recurring operational-information problems from field experience;
- abstract those problems without publishing confidential operational information;
- translate them into contracts, states, evidence rules, tests, and interfaces;
- distinguish reported, evidenced, pending, conflicting, unknown, and synthetic states;
- connect mining context with data science, operational systems, and governed AI;
- sustain a coherent body of work across multiple shutdown cases;
- preserve human and site authority at every boundary.

## Position in the portfolio

| Repository | Role |
|---|---|
| [Operational Systems Design](https://github.com/MartinnCG/operational-systems-design) | Central architecture and portfolio governance |
| [Edge Operational Evidence System](https://github.com/MartinnCG/edge-operational-evidence-system) | Evidence capture, integrity, reliability, and edge patterns |
| [Corredor de Altura](https://github.com/MartinnCG/corredor-altura) | Geospatial data-science application |
| [AI/ML Systems Architecture Labs](https://github.com/MartinnCG/ai-ml-systems-architecture-labs) | Governed AI/ML patterns |
| **Mining Operational Evidence Lab** | Mining-domain translation and synthetic operational cases |

## First architectural decisions

- **Case unit:** one bounded shutdown experience and its later synthetic analytical model.
- **Handover unit:** work front, which may contain multiple tasks and dependencies.
- **Operational persona:** incoming supervisor.
- **Initial value problem:** distinguish reported state, evidence-supported state, pending evidence, conflicting evidence, and unknown state.
- **External beneficiary:** the client, recruiter, or company evaluating the body of work.

These are testable design decisions, not claims about one employer's process.

## Public evidence boundary

Named operations or assets may appear only as contextual identifiers when they are independently public, cited, and compatible with Martin's contractual and site-policy obligations.

This repository does **not** publish:

- real rosters, live work status, incidents, permits, isolations, work packs, procedures, photographs, or access details;
- names or identifying details of workers, crews, contractors, or supervisors;
- confidential production, maintenance, workforce, commercial, or safety information;
- instructions that replace site procedures, competent persons, statutory roles, or safety authority;
- claims that an artifact was deployed, approved, or used by an employer unless independently documented.

Field experience defines the questions. Published operational records are synthetic, generalized, openly sourced, or reproducibly derived.

See [Confidentiality and Claims Boundary](docs/confidentiality-and-claims-boundary.md).

## Roadmap

- **M0 — Foundation:** scope, claims boundary, architecture, learning protocol, and contribution rules.
- **M0.1 — Case system:** case definition, reusable template, register, and initial named contexts.
- **M1 — Handover contract:** canonical synthetic event/state model and acceptance criteria.
- **M2 — Scenario generator:** reproducible synthetic shifts, work fronts, interruptions, and evidence gaps.
- **M3 — Evidence integration:** export to the Operational Evidence Envelope and cross-repository validation.
- **M4 — Governed decision brief:** consume evidence through an AI/ML lab without allowing unsupported claims.
- **M5 — Longitudinal study:** compare patterns across multiple synthetic shutdown cases.
- **M6 — Power BI synthesis:** build the final executive and analytical layer after the multi-shutdown evidence base is mature.

## Status

Foundation and case definition in progress. No production deployment, employer endorsement, or real operational dataset is claimed.

## License

MIT. Documentation and examples remain subject to the confidentiality and claims boundary above.
