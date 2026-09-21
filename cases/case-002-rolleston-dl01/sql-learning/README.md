# Restore guide

Open [restore_checkpoint.sql](restore_checkpoint.sql) in SQL Server Management Studio, connected to a local development instance. Run the entire file.

The script creates a separate database named `MiningLab_Restore_S01`. It does not modify `MiningLab`. Database-creation permissions are required.

If the target already contains tables in the `ops` schema, the script stops without overwriting them. Schema creation and inserts run inside a transaction. A newly created database may remain empty if loading fails.

This is a logical reconstruction, not a native `.bak` or a direct export from the user's computer. Constraint metadata may differ from the original. Public redactions are documented in the SQL header.

## Validation

The final query shows counts by table. The script checks expected counts and relationship consistency before committing.

Source-data keys, references and timestamp spans were checked during preparation. The consolidated script has **not been executed against SQL Server by the assistant**; a local restore remains necessary to validate execution.

Existing nullable fields and schema limitations are preserved. This checkpoint does not add production deployment guarantees.
