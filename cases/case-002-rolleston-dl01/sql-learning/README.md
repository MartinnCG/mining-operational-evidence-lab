# SQL learning backup index

## Available backups

| Swing | Artifact | Expected rows: cases / shifts / activities / links / dependencies / contexts |
|---|---|---|
| 001 | [September checkpoint](restore_checkpoint.sql) | 1 / 10 / 8 / 12 / 5 / 5 |
| 002 | [Original uploaded SQL script](swing-002/03_load_rolleston_swing02.sql) | 1 / 9 / 8 / 10 / 1 / 5 |
| 003 | [Load and per-shift refinement](swing-003/README.md) | 1 / 10 / 4 / 14 / 5 / 8 |

Swing 002 was uploaded by the user on 17 October 2026. Its SQL text and line endings are preserved, with any UTF-8 BOM omitted by text decoding. No SQL statements or narratives were edited. The script requires the existing ops schema, targets MiningLab and refuses to insert the same case twice. It uses a transaction and validates counts and associations. It has not been executed by the assistant; previously shared local query results match the expected counts.

Swing 003 scripts were reconstructed from the learning conversation. These incremental files are not a native SQL Server backup and do not include the Power BI report. Hail Creek's SQL load and a current consolidated database export remain outside this backup set. The older case-record.yaml is still the swing 1 narrative.

For a recovery rehearsal, create a separate compatible database and change the USE statements in the incremental scripts to that database. Never rerun loads against cases already present.

## Swing 001 restore guide

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
