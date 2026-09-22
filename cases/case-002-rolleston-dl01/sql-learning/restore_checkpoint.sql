/*
SQL learning checkpoint — completed Swing 001.
Evidence class: PERSONAL_EXPERIENCE (retrospective self-report).
Adapted from the user's SSMS export MiningLab_checkpoint_20260922.sql.
Original Spanish narratives preserved. Outcome notes are personal recollections,
not independently verified completion or maintenance sign-off. Not a native .bak.
Public redactions: crew_code = PRIVATE; crew removed from case_code.
Named context and dates follow ../evidence-boundaries.md.
No colleague identities, roster image, permits, measured delays or sign-offs.
Times are Queensland local time. Shift span is not productive time.
Read README.md. Run this entire file in SSMS against a NEW restore database.
*/
USE master;
GO
IF DB_ID(N'MiningLab_Restore_20260922') IS NULL
    EXEC(N'CREATE DATABASE MiningLab_Restore_20260922');
GO
USE MiningLab_Restore_20260922;
GO
SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;
    -- Stop rather than overwrite an existing checkpoint.
    IF EXISTS (
        SELECT 1 FROM sys.tables t
        JOIN sys.schemas s ON s.schema_id = t.schema_id
        WHERE s.name = N'ops'
    )
        THROW 51000, 'Target contains ops tables; no data changed.', 1;
    IF SCHEMA_ID(N'ops') IS NULL EXEC(N'CREATE SCHEMA ops');

    CREATE TABLE ops.ShutdownCase (
        case_id INT NOT NULL PRIMARY KEY,
        case_code VARCHAR(50) NOT NULL UNIQUE,
        site_name NVARCHAR(100) NOT NULL,
        asset_name NVARCHAR(100) NOT NULL,
        contractor_name NVARCHAR(100) NOT NULL,
        crew_code VARCHAR(10) NOT NULL,
        source_note NVARCHAR(1000) NOT NULL
    );

    CREATE TABLE ops.WorkShift (
        shift_id INT NOT NULL PRIMARY KEY,
        case_id INT NOT NULL REFERENCES ops.ShutdownCase(case_id),
        swing_shift_number TINYINT NOT NULL CHECK (swing_shift_number > 0),
        shift_type CHAR(2) NOT NULL CHECK (shift_type IN ('DS', 'NS')),
        starts_at DATETIME2(0) NOT NULL,
        ends_at DATETIME2(0) NOT NULL,
        UNIQUE (case_id, swing_shift_number),
        CHECK (ends_at > starts_at)
    );

    CREATE TABLE ops.Activity (
        activity_id INT NOT NULL PRIMARY KEY,
        area NVARCHAR(100) NOT NULL,
        description NVARCHAR(500) NOT NULL,
        outcome_note NVARCHAR(500) NULL,
        case_id INT NOT NULL REFERENCES ops.ShutdownCase(case_id),
        observation_type VARCHAR(20) NOT NULL CHECK (observation_type IN ('OBSERVED', 'SIMULATED'))
    );

    CREATE TABLE ops.ActivityShift (
        activity_id INT NOT NULL REFERENCES ops.Activity(activity_id),
        shift_id INT NOT NULL REFERENCES ops.WorkShift(shift_id),
        assignment_basis NVARCHAR(200) NOT NULL,
        PRIMARY KEY (activity_id, shift_id)
    );

    CREATE TABLE ops.DependencyObservation (
        dependency_id INT NOT NULL PRIMARY KEY,
        case_id INT NOT NULL REFERENCES ops.ShutdownCase(case_id),
        dependency_type NVARCHAR(100) NOT NULL,
        observation_note NVARCHAR(1000) NOT NULL
    );

    CREATE TABLE ops.CaseContext (
        context_id INT NOT NULL PRIMARY KEY,
        case_id INT NOT NULL REFERENCES ops.ShutdownCase(case_id),
        topic NVARCHAR(100) NOT NULL,
        context_note NVARCHAR(1500) NOT NULL
    );

INSERT [ops].[ShutdownCase] ([case_id], [case_code], [site_name], [asset_name], [contractor_name], [crew_code], [source_note]) VALUES (1, N'ROL-DL01-S01-202609', N'Rolleston', N'Dragline DL01', N'Richglen', N'PRIVATE', N'Caso basado en experiencia personal de Martin como TA y Firewatcher. No es un registro oficial del contratista.');

INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (1, 1, 1, N'DS', CAST(N'2026-09-07T06:30:00.0000000' AS DateTime2), CAST(N'2026-09-07T18:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (2, 1, 2, N'DS', CAST(N'2026-09-08T06:30:00.0000000' AS DateTime2), CAST(N'2026-09-08T18:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (3, 1, 3, N'DS', CAST(N'2026-09-09T06:30:00.0000000' AS DateTime2), CAST(N'2026-09-09T18:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (4, 1, 4, N'DS', CAST(N'2026-09-10T06:30:00.0000000' AS DateTime2), CAST(N'2026-09-10T18:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (5, 1, 5, N'DS', CAST(N'2026-09-11T06:30:00.0000000' AS DateTime2), CAST(N'2026-09-11T18:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (6, 1, 6, N'NS', CAST(N'2026-09-12T18:30:00.0000000' AS DateTime2), CAST(N'2026-09-13T06:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (7, 1, 7, N'NS', CAST(N'2026-09-13T18:30:00.0000000' AS DateTime2), CAST(N'2026-09-14T06:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (8, 1, 8, N'NS', CAST(N'2026-09-14T18:30:00.0000000' AS DateTime2), CAST(N'2026-09-15T06:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (9, 1, 9, N'NS', CAST(N'2026-09-15T18:30:00.0000000' AS DateTime2), CAST(N'2026-09-16T06:30:00.0000000' AS DateTime2));
INSERT [ops].[WorkShift] ([shift_id], [case_id], [swing_shift_number], [shift_type], [starts_at], [ends_at]) VALUES (10, 1, 10, N'NS', CAST(N'2026-09-16T18:30:00.0000000' AS DateTime2), CAST(N'2026-09-17T06:30:00.0000000' AS DateTime2));

INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (1, N'Machinery house', N'Retiro de plates del cilindro que enrolla el cable. Actividad del equipo; participación personal como TA y Firewatcher.', N'Trabajo descrito completado, según confirmación personal de Martin. No representa una aprobación técnica ni un cierre oficial.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (2, N'Área general del shutdown', N'Preparación inicial del lugar durante los primeros turnos de día. Participación como TA en el setup, en un contexto de movimiento de grúas y barricadas.', N'Trabajo descrito completado, según confirmación personal de Martin. No representa una aprobación técnica ni un cierre oficial.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (3, N'Girders', N'Trabajo del equipo principalmente durante los últimos tres turnos. Participación personal como TA y Firewatcher, con preparación de herramientas y apoyo manual al tradie.', N'Trabajo parcialmente realizado y preparado para continuar en el siguiente turno, según recuerdo personal.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (4, N'Walking shoes', N'Soldadura de plates realizada por el tradie. Participación personal como TA y Firewatcher: preparación de herramientas y apoyo manual, sin realizar soldadura ni operar herramientas.', N'Trabajo descrito completado, según confirmación personal de Martin. No representa una aprobación técnica ni un cierre oficial.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (5, N'Machinery house - techo de recámara interna', N'Retiro de placas del techo mediante gouging realizado por el tradie. Participación personal como TA y Firewatcher, sin operar herramientas.', N'Trabajo descrito completado, según confirmación personal de Martin. No representa una aprobación técnica ni un cierre oficial.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (6, N'Barandas', N'Soldadura de barandas nuevas donde se habían removido las anteriores, realizada por el tradie. Participación personal como TA y Firewatcher.', N'Trabajo descrito completado, según confirmación personal de Martin. No representa una aprobación técnica ni un cierre oficial.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (7, N'Walkway exterior', N'Remoción de mesh en los walkways de ambos lados del dragline y posterior corte con oxy de la plancha metálica del walkway para incorporar una pieza al dragline. Participación personal como TA y Firewatcher, sin operar herramientas ni realizar el corte.', N'Trabajo descrito completado, según confirmación personal de Martin. No representa una aprobación técnica ni un cierre oficial.', 1, N'OBSERVED');
INSERT [ops].[Activity] ([activity_id], [area], [description], [outcome_note], [case_id], [observation_type]) VALUES (8, N'Walking shoes', N'Preparación de material y plates para los soldadores que trabajaban en walking shoes. Participación personal como TA, sin realizar soldadura ni operar herramientas.', N'Preparación de material y plates completada durante el turno 7 de noche, según confirmación personal de Martin.', 1, N'OBSERVED');

INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (1, 10, N'Relato personal: trabajo en el cilindro la última noche.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (2, 1, N'Reconstrucción según relato personal: setup durante los primeros dos días.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (2, 2, N'Reconstrucción según relato personal: setup durante los primeros dos días.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (3, 8, N'Relato personal: girders durante los últimos tres turnos.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (3, 9, N'Relato personal: girders durante los últimos tres turnos.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (3, 10, N'Relato personal: girders y posterior reasignación al house.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (4, 4, N'Turno 4 de día, confirmado por recuerdo personal de Martin.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (4, 6, N'Turno indicado por Martin: primera noche, walking shoes.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (5, 4, N'Turno 4 de día: placas del techo de una recámara interna del house, según corrección personal de Martin.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (6, 5, N'Turno 5 de día: asistencia y firewatch durante la soldadura de nuevas piezas de guardrails del house, según recuerdo personal.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (7, 3, N'Turno 3 de día, confirmado por recuerdo personal de Martin.');
INSERT [ops].[ActivityShift] ([activity_id], [shift_id], [assignment_basis]) VALUES (8, 7, N'Preparación de plates en el turno 7 de noche, confirmada por recuerdo personal de Martin.');

INSERT [ops].[DependencyObservation] ([dependency_id], [case_id], [dependency_type], [observation_note]) VALUES (1, 1, N'Reposición de gas', N'Al agotarse el gas para oxy cutting, el trabajo esperaba su reposición mediante transporte o grúa. Sin duración medida.');
INSERT [ops].[DependencyObservation] ([dependency_id], [case_id], [dependency_type], [observation_note]) VALUES (2, 1, N'Disponibilidad de grúa', N'Para algunos trabajos dentro del house se esperaba que la grúa subiera herramientas y equipos de soldadura.');
INSERT [ops].[DependencyObservation] ([dependency_id], [case_id], [dependency_type], [observation_note]) VALUES (3, 1, N'Instalación de scaffold', N'El inicio de trabajos en el walkway dependía de que terminara la instalación del scaffold.');
INSERT [ops].[DependencyObservation] ([dependency_id], [case_id], [dependency_type], [observation_note]) VALUES (4, 1, N'Trabajo previo de otros equipos', N'En el house, algunas tareas debían esperar a que fitters y doggies terminaran su intervención.');
INSERT [ops].[DependencyObservation] ([dependency_id], [case_id], [dependency_type], [observation_note]) VALUES (5, 1, N'Movimiento de cargas suspendidas', N'Durante movimientos que interferían con el trabajo, el equipo interrumpía la tarea o se desplazaba y continuaba después.');

INSERT [ops].[CaseContext] ([context_id], [case_id], [topic], [context_note]) VALUES (1, 1, N'Prestart', N'Según relato personal: de 06:30 a 06:45 o de 18:30 a 18:45. Se revisaban el turno anterior, hazards, controles, aciertos y mejoras. Participaban las áreas mechanical, structural, electrical y ancillary/cleaners.');
INSERT [ops].[CaseContext] ([context_id], [case_id], [topic], [context_note]) VALUES (2, 1, N'Asignación de tareas', N'Después del prestart, el supervisor de cada área reunía al equipo y asignaba tareas y parejas. Se utilizaban pizarras y una hoja de asignaciones. Martin trabajó de forma rotativa al inicio y aproximadamente desde el cuarto día con el mismo tradie.');
INSERT [ops].[CaseContext] ([context_id], [case_id], [topic], [context_note]) VALUES (3, 1, N'Cierre y relevo', N'El equipo buscaba terminar las tareas o dejarlas parcialmente realizadas y preparadas para el turno siguiente. En ocasiones el supervisor revisaba previamente. Este relato no acredita aprobación formal de cada actividad.');
INSERT [ops].[CaseContext] ([context_id], [case_id], [topic], [context_note]) VALUES (4, 1, N'Participación personal', N'Martin participó como Trade Assistant y Firewatcher en structural, preparando herramientas y dando apoyo manual al tradie. Sin soldadura ni operación de herramientas en este registro. Los trabajos en confined space mencionados fueron realizados por compañeros.');
INSERT [ops].[CaseContext] ([context_id], [case_id], [topic], [context_note]) VALUES (5, 1, N'Esperas', N'Martin recuerda las esperas principalmente de noche y describe completar SLAM o Take 5 durante esas pausas. No se dispone de tiempos medidos ni de una cantidad de eventos.');

    IF (SELECT COUNT(*) FROM ops.ShutdownCase) <> 1
        THROW 51001, 'Unexpected row count: ShutdownCase', 1;
    IF (SELECT COUNT(*) FROM ops.WorkShift) <> 10
        THROW 51001, 'Unexpected row count: WorkShift', 1;
    IF (SELECT COUNT(*) FROM ops.Activity) <> 8
        THROW 51001, 'Unexpected row count: Activity', 1;
    IF (SELECT COUNT(*) FROM ops.ActivityShift) <> 12
        THROW 51001, 'Unexpected row count: ActivityShift', 1;
    IF (SELECT COUNT(*) FROM ops.DependencyObservation) <> 5
        THROW 51001, 'Unexpected row count: DependencyObservation', 1;
    IF (SELECT COUNT(*) FROM ops.CaseContext) <> 5
        THROW 51001, 'Unexpected row count: CaseContext', 1;

    IF EXISTS (
        SELECT 1 FROM ops.ActivityShift r
        JOIN ops.Activity a ON a.activity_id = r.activity_id
        JOIN ops.WorkShift s ON s.shift_id = r.shift_id
        WHERE a.case_id IS NULL OR a.case_id <> s.case_id
    ) THROW 51002, 'Activity and shift case mismatch.', 1;
    IF EXISTS (
        SELECT 1 FROM ops.WorkShift
        WHERE DATEDIFF(MINUTE, starts_at, ends_at) <> 720
    ) THROW 51003, 'Unexpected shift span.', 1;
    IF EXISTS (SELECT 1 FROM ops.Activity WHERE outcome_note IS NULL OR observation_type <> 'OBSERVED')
        THROW 51004, 'Unexpected activity evidence or outcome.', 1;
    IF EXISTS (
        SELECT 1 FROM ops.WorkShift w
        WHERE NOT EXISTS (SELECT 1 FROM ops.ActivityShift s WHERE s.shift_id = w.shift_id)
    ) THROW 51005, 'Shift without an activity link.', 1;
    IF NOT EXISTS (SELECT 1 FROM ops.ActivityShift WHERE activity_id = 5 AND shift_id = 4)
       OR EXISTS (SELECT 1 FROM ops.ActivityShift WHERE activity_id = 5 AND shift_id <> 4)
        THROW 51006, 'Roof activity must link only to shift 4.', 1;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- Expected counts: 1 case, 10 shifts, 8 activities, 12 links, 5 dependencies, 5 notes.
SELECT N'ShutdownCase' AS table_name, COUNT(*) AS row_count FROM ops.ShutdownCase
UNION ALL
SELECT N'WorkShift' AS table_name, COUNT(*) AS row_count FROM ops.WorkShift
UNION ALL
SELECT N'Activity' AS table_name, COUNT(*) AS row_count FROM ops.Activity
UNION ALL
SELECT N'ActivityShift' AS table_name, COUNT(*) AS row_count FROM ops.ActivityShift
UNION ALL
SELECT N'DependencyObservation' AS table_name, COUNT(*) AS row_count FROM ops.DependencyObservation
UNION ALL
SELECT N'CaseContext' AS table_name, COUNT(*) AS row_count FROM ops.CaseContext;
GO
