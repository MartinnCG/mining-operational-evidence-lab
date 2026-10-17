USE [MiningLab];
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    /* 1. Identificar el caso y reservar IDs. */
    DECLARE @Code varchar(50) = 'ROL-DL01-A-S02-202609';
    DECLARE @CaseId int;
    DECLARE @ShiftBase int;
    DECLARE @ActivityBase int;
    DECLARE @DependencyBase int;
    DECLARE @ContextBase int;

    SELECT @CaseId = ISNULL(MAX(case_id), 0) + 1
    FROM ops.ShutdownCase WITH (TABLOCKX, HOLDLOCK);

    IF EXISTS (
        SELECT 1
        FROM ops.ShutdownCase
        WHERE case_code = @Code
    )
        THROW 51200,
            'El swing 2 ya existe. No se insertaron registros.',
            1;

    SELECT @ShiftBase = ISNULL(MAX(shift_id), 0)
    FROM ops.WorkShift WITH (TABLOCKX, HOLDLOCK);

    SELECT @ActivityBase = ISNULL(MAX(activity_id), 0)
    FROM ops.Activity WITH (TABLOCKX, HOLDLOCK);

    SELECT @DependencyBase = ISNULL(MAX(dependency_id), 0)
    FROM ops.DependencyObservation WITH (TABLOCKX, HOLDLOCK);

    SELECT @ContextBase = ISNULL(MAX(context_id), 0)
    FROM ops.CaseContext WITH (TABLOCKX, HOLDLOCK);

    /* 2. Crear el caso. */
    INSERT INTO ops.ShutdownCase (
        case_id, case_code, site_name, asset_name,
        contractor_name, crew_code, source_note
    )
    VALUES (
        @CaseId,
        @Code,
        N'Rolleston',
        N'Dragline DL01',
        N'Richglen',
        'A',
        N'Segundo swing. Calendario reconstruido a partir del roster '
        + N'de Crew A enviado el 28/08/2026 y asistencia confirmada por Martin. '
        + N'Actividades y resultados basados en relato personal como TA, '
        + N'Firewatcher y apoyo en trabajos en espacios confinados. '
        + N'No constituye registro corporativo ni aprobación técnica.'
    );

    /* 3. Turnos efectivamente trabajados.
       turno_swing conserva la numeración original: 2 a 10.
       La fecha de las noches corresponde a su INICIO. */
    INSERT INTO ops.WorkShift (
        shift_id, case_id, swing_shift_number,
        shift_type, starts_at, ends_at
    )
    SELECT
        @ShiftBase + v.secuencia,
        @CaseId,
        v.turno_swing,
        v.tipo,
        CONVERT(datetime2(0), v.inicio),
        CONVERT(datetime2(0), v.fin)
    FROM (
        VALUES
        (1, 2, 'DS', '2026-09-23T06:30:00', '2026-09-23T18:30:00'),
        (2, 3, 'DS', '2026-09-24T06:30:00', '2026-09-24T18:30:00'),
        (3, 4, 'DS', '2026-09-25T06:30:00', '2026-09-25T18:30:00'),
        (4, 5, 'DS', '2026-09-26T06:30:00', '2026-09-26T18:30:00'),
        (5, 6, 'NS', '2026-09-27T18:30:00', '2026-09-28T06:30:00'),
        (6, 7, 'NS', '2026-09-28T18:30:00', '2026-09-29T06:30:00'),
        (7, 8, 'NS', '2026-09-29T18:30:00', '2026-09-30T06:30:00'),
        (8, 9, 'NS', '2026-09-30T18:30:00', '2026-10-01T06:30:00'),
        (9,10, 'NS', '2026-10-01T18:30:00', '2026-10-02T06:30:00')
    ) v(secuencia, turno_swing, tipo, inicio, fin);

    /* 4. Actividades observadas.
       Los textos diferencian participación personal y trabajo del equipo. */
    INSERT INTO ops.Activity (
        activity_id, area, description,
        outcome_note, case_id, observation_type
    )
    VALUES
    (
        @ActivityBase + 1,
        N'Boom izquierdo - LA12 y LA13',
        N'Preparación del frente de soldadura: instalación de brattice '
        + N'sobre scaffold mediante sogas y precintos para reducir la entrada '
        + N'de viento. Organización de herramientas, consumibles y documentos '
        + N'en una estación entre ambas secciones. Participación como '
        + N'TA/Spotter/Firewatcher.',
        N'Frente acondicionado y trabajos observados parcialmente. '
        + N'Martin no presenció la terminación de la intervención.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 2,
        N'Boom izquierdo - LA13',
        N'Preparación y delimitación con caution tape para recibir segmentos '
        + N'tubulares destinados a reparación. Participación como TA manipulando '
        + N'eslingas y come-along para ajustar la posición del tramo y facilitar '
        + N'la presentación de piezas. Ajuste de altura y sujeción de la cobertura '
        + N'de brattice y lonas sobre scaffold. Corte, preparación y soldadura '
        + N'correspondían al trabajo del equipo.',
        N'Preparación y posicionamiento observados en curso. '
        + N'Resultado parcial; terminación no observada.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 3,
        N'Boom derecho - RB5',
        N'Asistencia al boilermaker para radius blending dentro del miembro '
        + N'tubular B, sección 5. Preparación de consumibles, amoladora angular, '
        + N'die grinder e iluminación portátil a batería. '
        + N'Participación como TA; sin operación personal de amoladora '
        + N'en esta intervención.',
        N'Avance parcial observado. Martin no presenció la terminación.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 4,
        N'Left propel - bore',
        N'Ingreso al espacio confinado como TA para preparar el puesto y asistir '
        + N'al boilermaker. El trabajo del equipo comprendía eliminación de grasa, '
        + N'limpieza y preparación de cavidades, seguida de aporte de soldadura. '
        + N'Preparación y suministro de herramientas y consumibles para soldadura, '
        + N'amoladoras y needle gun. Se mencionó también un soplete con llama '
        + N'identificado verbalmente como APG.',
        N'Trabajo en ejecución sostenida según relato personal. '
        + N'Terminación no confirmada.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 5,
        N'Right propel - girder',
        N'Organización del frente junto con otros TA y ordenamiento de cables '
        + N'y equipos para trabajos sobre el girder. La intervención posterior '
        + N'de boilermakers dependía del posicionamiento y ajuste por fitters '
        + N'y grúa. El relato incluye oxy cutting por el equipo para limpieza '
        + N'y remoción de material en la zona superior, sin atribuir su operación '
        + N'personal al TA.',
        N'Frente preparado. Según Martin, el trabajo posterior comenzó al día '
        + N'siguiente después de terminar los fitters. '
        + N'No se confirmó el cierre de la reparación.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 6,
        N'Machinery house - bore',
        N'Asistencia al boilermaker durante building up: aporte de cordones '
        + N'de soldadura sobre la superficie interior del bore y posterior '
        + N'trabajo con amoladora y/o needle gun. Participación personal '
        + N'en ajustes de amperaje y anotación de temperaturas relacionadas '
        + N'con la soldadura en heat sheets.',
        N'Trabajo continuado durante dos noches y próximo a terminar '
        + N'según recuerdo personal. Terminación final no confirmada. '
        + N'La anotación de temperaturas no acredita aceptación técnica.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 7,
        N'Machinery house - otro bore',
        N'Preparación de otro puesto para el relevo: traslado de soldadora, '
        + N'preparación del sistema de alimentación de alambre y disposición '
        + N'ordenada de cables de soldadura, alimentación eléctrica y mangueras '
        + N'de argón y aire. Participación como TA para dejar disponibles '
        + N'los equipos del turno entrante.',
        N'Puesto preparado para continuidad en el siguiente turno. '
        + N'Este resultado corresponde al setup, no al cierre de la reparación.',
        @CaseId, 'OBSERVED'
    ),
    (
        @ActivityBase + 8,
        N'Left propel - apoyo exterior a confined space',
        N'Permanencia fuera del espacio confinado en la última noche, '
        + N'con comunicación por radio con personal del interior y suministro '
        + N'de herramientas, elementos y consumibles. Martin identifica '
        + N'su función exterior como standby person designado.',
        N'Apoyo a la continuidad de los trabajos. '
        + N'Terminación de la reparación no confirmada.',
        @CaseId, 'OBSERVED'
    );

    /* 5. Vincular actividades con turnos del nuevo caso.
       Se busca cada turno por caso y número, no por un ID supuesto. */
    INSERT INTO ops.ActivityShift (
        activity_id, shift_id, assignment_basis
    )
    SELECT
        @ActivityBase + v.actividad,
        w.shift_id,
        v.fundamento
    FROM (
        VALUES
        (1, 2, N'Relato personal: preparación de LA12/LA13 en los turnos 2 y 3.'),
        (1, 3, N'Relato personal: continuidad del apoyo en LA12/LA13.'),
        (2, 4, N'Relato personal: posicionamiento y acondicionamiento en LA13, turno 4.'),
        (3, 5, N'Relato personal: preparación para radius blending en RB5, turno 5.'),
        (4, 6, N'Relato personal: primera noche, asistencia dentro de left propel.'),
        (5, 7, N'Relato personal: segunda noche, preparación de right propel.'),
        (6, 8, N'Relato personal: tercera noche, building up y heat sheets en el house.'),
        (6, 9, N'Relato personal: cuarta noche, continuidad del bore del house.'),
        (7, 9, N'Relato personal: cuarta noche, preparación de otro bore para el relevo.'),
        (8,10, N'Relato personal: quinta noche, apoyo exterior y comunicación por radio.')
    ) v(actividad, turno_swing, fundamento)
    JOIN ops.WorkShift w
        ON w.case_id = @CaseId
       AND w.swing_shift_number = v.turno_swing;

    /* 6. Dependencia observada.
       Registro narrativo: no se inventan horas de espera. */
    INSERT INTO ops.DependencyObservation (
        dependency_id, case_id, dependency_type, observation_note
    )
    VALUES (
        @DependencyBase + 1,
        @CaseId,
        N'Posicionamiento previo por fitters y grúa',
        N'En right propel, el trabajo posterior de los boilermakers dependía '
        + N'de completar el posicionamiento y ajuste del girder por fitters '
        + N'y grúa. Martin preparó el frente durante la segunda noche y '
        + N'relata que el trabajo posterior comenzó al día siguiente, '
        + N'tras finalizar los fitters. No se midió la duración de la espera '
        + N'ni se dispone de registro formal de liberación.'
    );

    /* 7. Contexto del caso. */
    INSERT INTO ops.CaseContext (
        context_id, case_id, topic, context_note
    )
    VALUES
    (
        @ContextBase + 1, @CaseId,
        N'Calendario y asistencia',
        N'Crew A, Richglen, Dragline DL01. Día 1 del swing: 22/09/2026, '
        + N'no trabajado por Martin según su relato. Turnos trabajados 2 a 5: '
        + N'23 al 26/09, 06:30-18:30. Cinco noches consecutivas iniciadas '
        + N'entre el 27/09 y el 01/10, 18:30-06:30 del día siguiente. '
        + N'Última salida: 02/10/2026 a las 06:30. '
        + N'Los intervalos no representan horas productivas medidas.'
    ),
    (
        @ContextBase + 2, @CaseId,
        N'Fuente del calendario',
        N'Correo Rolleston DL1 Shutdown - A Crew Job Details del 28/08/2026 '
        + N'y adjunto ROL DL01 Shut - A Crew Roster 20260828.pdf. '
        + N'El correo especifica que N/S se representa por la fecha '
        + N'de finalización. El roster aporta programación; la asistencia '
        + N'y las actividades se reconstruyen con el relato de Martin.'
    ),
    (
        @ContextBase + 3, @CaseId,
        N'Nomenclatura del boom',
        N'Según explicación recibida en campo: L/R identifica lado '
        + N'izquierdo/derecho; A corresponde al miembro tubular exterior, '
        + N'B al interior y C al superior. LA12/LA13: lado izquierdo, '
        + N'miembro A, secciones 12 y 13. RB5: lado derecho, miembro B, '
        + N'sección 5. No se adjuntó plano técnico para verificación independiente.'
    ),
    (
        @ContextBase + 4, @CaseId,
        N'Roles y participación personal',
        N'TA/Spotter/Firewatcher en los frentes descritos. Martin confirmó '
        + N'ingreso para tareas de TA en espacios confinados en este swing. '
        + N'En la última noche permaneció fuera, como standby person '
        + N'designado según su relato, con comunicación por radio con personal '
        + N'del interior. Confirmó manipulación de eslingas y come-along. '
        + N'No se atribuye dirección de maniobras, soldadura, autorización '
        + N'de entrada ni certificación del trabajo.'
    ),
    (
        @ContextBase + 5, @CaseId,
        N'Herramientas, temperaturas y límites',
        N'La preparación de amoladoras y die grinders no implica operación '
        + N'personal; Martin indicó que no necesitó operar grinder. '
        + N'Los ajustes sobre scaffold descritos corresponden a coberturas '
        + N'de brattice y lonas. APG se conserva como denominación verbal '
        + N'no resuelta de un soplete con llama. Heat sheets: anotación '
        + N'de temperaturas, sin valores ni umbrales disponibles. '
        + N'Los resultados parciales no acreditan cierres técnicos.'
    );

    /* 8. Validar la carga antes de confirmarla. */
    IF (SELECT COUNT(*) FROM ops.WorkShift
        WHERE case_id = @CaseId) <> 9
        THROW 51201, 'La carga no contiene los 9 turnos esperados.', 1;

    IF (SELECT COUNT(*) FROM ops.WorkShift
        WHERE case_id = @CaseId AND shift_type = 'DS') <> 4
        THROW 51202, 'La carga no contiene los 4 turnos DS esperados.', 1;

    IF (SELECT COUNT(*) FROM ops.WorkShift
        WHERE case_id = @CaseId AND shift_type = 'NS') <> 5
        THROW 51203, 'La carga no contiene los 5 turnos NS esperados.', 1;

    IF (SELECT COUNT(*) FROM ops.Activity
        WHERE case_id = @CaseId) <> 8
        THROW 51204, 'La carga no contiene las 8 actividades esperadas.', 1;

    IF (
        SELECT COUNT(*)
        FROM ops.ActivityShift b
        JOIN ops.WorkShift w ON w.shift_id = b.shift_id
        WHERE w.case_id = @CaseId
    ) <> 10
        THROW 51205, 'La carga no contiene las 10 asignaciones esperadas.', 1;

    IF EXISTS (
        SELECT 1
        FROM ops.ActivityShift b
        JOIN ops.Activity a ON a.activity_id = b.activity_id
        JOIN ops.WorkShift w ON w.shift_id = b.shift_id
        WHERE a.case_id <> w.case_id
    )
        THROW 51206, 'Existe una asociación entre casos diferentes.', 1;

    IF EXISTS (
        SELECT 1
        FROM ops.WorkShift w
        WHERE w.case_id = @CaseId
          AND NOT EXISTS (
              SELECT 1 FROM ops.ActivityShift b
              WHERE b.shift_id = w.shift_id
          )
    )
        THROW 51207, 'Hay un turno nuevo sin actividad asociada.', 1;

    IF EXISTS (
        SELECT 1
        FROM ops.Activity a
        WHERE a.case_id = @CaseId
          AND NOT EXISTS (
              SELECT 1 FROM ops.ActivityShift b
              WHERE b.activity_id = a.activity_id
          )
    )
        THROW 51208, 'Hay una actividad nueva sin turno asociado.', 1;

    IF (SELECT COUNT(*) FROM ops.DependencyObservation
        WHERE case_id = @CaseId) <> 1
        THROW 51209, 'Cantidad incorrecta de dependencias.', 1;

    IF (SELECT COUNT(*) FROM ops.CaseContext
        WHERE case_id = @CaseId) <> 5
        THROW 51210, 'Cantidad incorrecta de contextos.', 1;

    COMMIT TRANSACTION;

    PRINT 'SWING 2 CARGADO: transaccion confirmada y controles superados.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;

/* 9. Resultado general por caso. */
SELECT
    c.case_id,
    c.case_code,
    (SELECT COUNT(*) FROM ops.WorkShift w
     WHERE w.case_id = c.case_id) AS turnos,
    (SELECT COUNT(*) FROM ops.Activity a
     WHERE a.case_id = c.case_id) AS actividades,
    (SELECT COUNT(*)
     FROM ops.ActivityShift b
     JOIN ops.WorkShift w ON w.shift_id = b.shift_id
     WHERE w.case_id = c.case_id) AS asignaciones,
    (SELECT COUNT(*) FROM ops.DependencyObservation d
     WHERE d.case_id = c.case_id) AS dependencias,
    (SELECT COUNT(*) FROM ops.CaseContext x
     WHERE x.case_id = c.case_id) AS contextos
FROM ops.ShutdownCase c
ORDER BY c.case_id;

/* 10. Cronología del segundo swing. */
SELECT
    w.swing_shift_number AS turno_swing,
    w.shift_type,
    w.starts_at AS inicio,
    w.ends_at AS fin,
    a.activity_id,
    a.area,
    a.description,
    a.outcome_note,
    b.assignment_basis
FROM ops.ShutdownCase c
JOIN ops.WorkShift w ON w.case_id = c.case_id
JOIN ops.ActivityShift b ON b.shift_id = w.shift_id
JOIN ops.Activity a ON a.activity_id = b.activity_id
WHERE c.case_code = 'ROL-DL01-A-S02-202609'
ORDER BY w.swing_shift_number, a.activity_id;