# Restore guide

This checkpoint is adapted from the user's SSMS export `MiningLab_checkpoint_20260922.sql`. It preserves the exported Spanish narratives; this guide and SQL comments are in English. It is not a native SQL Server backup.

## Restore

1. Open [restore_checkpoint.sql](restore_checkpoint.sql) in SQL Server Management Studio connected to a local development instance.
2. Run the entire file once. Database-creation permissions are required.
3. Check the final row counts below.

The script creates `MiningLab_Restore_20260922` and the `ops` schema. It does not modify `MiningLab` or the earlier restore database. If the target already contains any ops tables, it stops without overwriting them. Schema creation and data loading run in a transaction; a failed load may leave an empty database.

## Expected counts

| Table | Rows |
|---|---:|
| ShutdownCase | 1 |
| WorkShift | 10 |
| Activity | 8 |
| ActivityShift | 12 |
| DependencyObservation | 5 |
| CaseContext | 5 |

The script checks counts, case consistency, shift spans, recorded outcomes, evidence classification, shift coverage, and the corrected activity-to-shift link before committing.

## Export adaptations

- Crew identity is removed from the case code; crew_code is PRIVATE.
- A separate target database and schema bootstrap are provided.
- Tables and inserts are ordered by dependency.
- Structural constraints are reconstructed; generated constraint names and physical index options are not a byte-for-byte copy of the export.
- Activity.case_id and observation_type are NOT NULL; the evidence check allows OBSERVED or SIMULATED.
- Narrative data is unchanged except for the declared identity redactions.

OBSERVED means retrospective personal experience here, not independently verified evidence. Outcome notes do not establish technical approval or official maintenance closure. Shift spans are not productive hours. ActivityShift rows are links, not unique activities or measured task durations. Cross-case consistency is checked on restore but is not enforced for future inserts by a composite foreign key.

## Verification status

Preparation checks compared all 41 exported rows against the prepared script after the declared redactions and checked link uniqueness, references, and shift coverage. GitHub content is read back after publication.

The assistant has **not executed this script against SQL Server**. A local restore and count check remain pending. Do not treat static verification as proof of successful restoration.

This is a learning checkpoint, not a production deployment or a complete multi-shutdown semantic model.
