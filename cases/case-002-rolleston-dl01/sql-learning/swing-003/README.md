# Swing 3 — incremental SQL learning backup

This folder preserves the SQL load and subsequent narrative correction requested by Martin on 17 October 2026. Spanish source narratives are retained; documentation is in English.

## Scope

These scripts were reconstructed from the blocks supplied in the learning conversation. Formatting and comments were condensed; the data values, guards and transactional behavior are retained. They are **not an export from the local SQL Server**, a native .bak backup, or a backup of the Power BI report.

The existing September checkpoint in the parent folder covers swing 1 only. This addition covers **Rolleston swing 3**. The user-uploaded [swing 2 load script](../swing-002/03_load_rolleston_swing02.sql) is now backed up separately. The Hail Creek SQL load is not included here. A complete four-case restore still requires a current schema-and-data export.

The user explicitly requested this operational-learning backup. It is kept on the existing backup branch, separate from the synthetic portfolio model on main. OBSERVED is the existing learning-schema label for retrospective personal testimony, not independent verification. No photographs, signatures or other workers' names are uploaded.

## Files and execution order

1. [04_load_rolleston_swing03.sql](04_load_rolleston_swing03.sql): adds the case and related records. Requires the existing six-table ops schema.
2. [05_refine_rolleston_swing03.sql](05_refine_rolleston_swing03.sql): adds nullable WorkShift.operational_summary, updates the ten summaries, and replaces only the scope/precision context note.

Both scripts currently target MiningLab. For a recovery rehearsal, use a separate database containing the compatible ops schema and change the USE statement in **both** scripts to that database.

Run each complete script in order in SSMS. Do not rerun the load against a database where the case already exists: it intentionally throws before inserting anything. The refinement can be reapplied, but replaces summaries and the designated context note with these saved versions.

Identifiers are allocated from existing table maxima inside transactions. Other cases are not reloaded or rewritten. The new summary column is NULL for older cases until separately populated.

## Expected swing 3 counts

| Table | Rows |
|---|---:|
| ShutdownCase | 1 |
| WorkShift | 10 |
| Activity | 4 |
| ActivityShift | 14 |
| DependencyObservation | 5 |
| CaseContext | 8 |

Case key: ROL-DL01-A-S03-202610. Five day shifts and five night shifts; last shift ends 17 October 2026 at 06:30 site-local time (Queensland). Dates are reconstructed from the confirmed endpoint and consecutive shifts.

## Reading the records

- Activity descriptions hold the shared work-front scope.
- WorkShift.operational_summary provides one narrative per shift.
- Daily narratives distribute emphasis across reported recurring routines. They are **not independently evidenced daily task logs**.
- Thermal-support links for shifts 6–9 identify the possible period, not four measured interventions.
- Four activities and fourteen links are not repair counts or productivity metrics.
- Whiteboard text documents planned work and communicated context, not proof of completed tasks or compliance.
- The user confirmed adopting board nomenclature LB5/RB5, LA6 and LC7/RC7.
- Completion reported by Martin does not establish inspection acceptance.
- No durations of delays, thermal parameters or percent-complete values were invented.

## Validation

The load checks expected counts, day/night split, activity/shift case consistency, link coverage and twelve-hour shift spans before commit. The refinement checks ten target shifts and exactly one scope-context update. Errors roll back the relevant transaction.

Preparation includes static checks of text lengths, expected row definitions and the ten distinct summaries. The assistant has **not executed these reconstructed files against SQL Server** or compared them with a fresh local database export. GitHub file contents are read back after committing.

The final query in the refinement returns ten rows. The load's detailed activity-to-shift query returns fourteen rows; that difference reflects the selected grain, not missing data.
