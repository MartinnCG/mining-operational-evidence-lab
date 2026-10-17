-- Reconstructed from the SQL block supplied in the learning session on 2026-10-17.
-- Incremental script: requires the existing ops schema. Not a database export.
USE MiningLab;
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @CaseCode varchar(50) = 'ROL-DL01-A-S03-202610';
DECLARE @CaseId int, @ShiftBase int, @ActivityBase int, @DependencyBase int, @ContextBase int;

BEGIN TRY
 BEGIN TRANSACTION;
 SELECT @CaseId = ISNULL(MAX(case_id),0)+1 FROM ops.ShutdownCase WITH(TABLOCKX,HOLDLOCK);
 IF EXISTS (SELECT 1 FROM ops.ShutdownCase WHERE case_code=@CaseCode)
  THROW 51001, 'El swing 3 ya existe. No se insertaron registros nuevos.', 1;
 SELECT @ShiftBase=ISNULL(MAX(shift_id),0) FROM ops.WorkShift WITH(TABLOCKX,HOLDLOCK);
 SELECT @ActivityBase=ISNULL(MAX(activity_id),0) FROM ops.Activity WITH(TABLOCKX,HOLDLOCK);
 SELECT @DependencyBase=ISNULL(MAX(dependency_id),0) FROM ops.DependencyObservation WITH(TABLOCKX,HOLDLOCK);
 SELECT @ContextBase=ISNULL(MAX(context_id),0) FROM ops.CaseContext WITH(TABLOCKX,HOLDLOCK);

 INSERT ops.ShutdownCase(case_id,case_code,site_name,asset_name,contractor_name,crew_code,source_note)
 VALUES(@CaseId,@CaseCode,N'Rolleston',N'Dragline DL01',N'Richglen','A',
 N'Registro basado en el relato personal de Martin Conti Graffigna y ocho fotografías de siete pizarras de prestart. Nomenclatura de frentes adoptada de las pizarras por confirmación de Martin: LB5/RB5, LA6 y LC7/RC7. Las pizarras documentan planificación y contexto; el relato documenta participación y resultados observados. No es un registro oficial del contratista ni acredita aceptación técnica.');

 INSERT ops.WorkShift(shift_id,case_id,swing_shift_number,shift_type,starts_at,ends_at)
 SELECT @ShiftBase+v.n,@CaseId,v.n,v.t,CONVERT(datetime2(0),v.s,126),CONVERT(datetime2(0),v.e,126)
 FROM(VALUES
 (1,'DS','2026-10-07T06:30:00','2026-10-07T18:30:00'),
 (2,'DS','2026-10-08T06:30:00','2026-10-08T18:30:00'),
 (3,'DS','2026-10-09T06:30:00','2026-10-09T18:30:00'),
 (4,'DS','2026-10-10T06:30:00','2026-10-10T18:30:00'),
 (5,'DS','2026-10-11T06:30:00','2026-10-11T18:30:00'),
 (6,'NS','2026-10-12T18:30:00','2026-10-13T06:30:00'),
 (7,'NS','2026-10-13T18:30:00','2026-10-14T06:30:00'),
 (8,'NS','2026-10-14T18:30:00','2026-10-15T06:30:00'),
 (9,'NS','2026-10-15T18:30:00','2026-10-16T06:30:00'),
 (10,'NS','2026-10-16T18:30:00','2026-10-17T06:30:00')
 )v(n,t,s,e);

 INSERT ops.Activity(activity_id,area,description,outcome_note,case_id,observation_type)
 VALUES
 (@ActivityBase+1,N'Boom - LB5/RB5',
 N'Acondicionamiento del frente sobre scaffold: soldadoras, cables, consumibles y brattice contra lluvia y viento. Asistencia a los tradies sosteniendo reglas y girando tubos para medición y presentación. Abastecimiento de herramientas y apoyo durante instalación, preparación superficial y soldadura de segmentos, realizadas por los tradies.',
 N'Según Martin, los trabajos en LB5/RB5 quedaron terminados, incluidos ensamblaje, preparación superficial y aporte de soldadura. No se confirmó el resultado de la inspección de fisuras ni la aceptación técnica.',@CaseId,'OBSERVED'),
 (@ActivityBase+2,N'Boom - LA6',
 N'Asistencia como TA a dos boilermakers. Preparación y puesta en servicio de soldadora y grupo electrógeno según relato, distribución de cables, organización del puesto y suministro de consumibles, amoladoras y otras herramientas. Apoyo a la continuidad del trabajo y participación en la preparación documental de permisos y JSA, sin atribuir autorización o aprobación.',
 N'Martin observó la terminación del trabajo en uno de los lados. El otro continuó con otro boilermaker y su TA al trasladarse su equipo a LC7/RC7. No se identificó el lado terminado ni se confirmó aceptación técnica.',@CaseId,'OBSERVED'),
 (@ActivityBase+3,N'Boom - LA6 - asistencia térmica',
 N'Comunicación por radio para coordinar al heat technician. Asistencia en la colocación de heat pads y recubrimientos, y acondicionamiento del puesto para facilitar el trabajo del soldador y reducir el contacto accidental con superficies calientes. No incluye definición de temperaturas, ciclos térmicos ni aprobación del tratamiento.',
 N'Apoyo prestado durante el período de trabajo en LA6. Sin desglose por noche, temperaturas, tiempos de aplicación, cantidad de intervenciones ni registros de aceptación del proceso térmico.',@CaseId,'OBSERVED'),
 (@ActivityBase+4,N'Boom - LC7/RC7',
 N'Reasignación del equipo de dos boilermakers y un TA al frente LC7/RC7. Preparación de equipos de soldadura, cables, herramientas y consumibles, con asistencia al inicio de la intervención. Continuidad de las funciones de abastecimiento y organización del puesto descritas para el trabajo con boom welders.',
 N'Frente iniciado durante la última noche de participación de Martin. No presenció la terminación de los trabajos.',@CaseId,'OBSERVED');

 INSERT ops.ActivityShift(activity_id,shift_id,assignment_basis)
 SELECT @ActivityBase+v.a,@ShiftBase+v.s,v.b
 FROM(VALUES
 (1,1,N'Relato personal: LB5/RB5 durante los cinco turnos de día. Subtareas descritas para el período, sin desglose diario confirmado.'),
 (1,2,N'Relato personal: LB5/RB5 durante los cinco turnos de día. Subtareas descritas para el período, sin desglose diario confirmado.'),
 (1,3,N'Relato personal: LB5/RB5 durante los cinco turnos de día. Subtareas descritas para el período, sin desglose diario confirmado.'),
 (1,4,N'Relato personal: LB5/RB5. Pizarra 10/10, Crew A, DS: pup install + weld out. La planificación no acredita cierre técnico.'),
 (1,5,N'Relato personal: LB5/RB5. Pizarra 11/10, Crew A, DS: pup install + weld out. La planificación no acredita cierre técnico.'),
 (2,6,N'Relato personal: primeras cuatro noches en el mismo frente. Código LA6 adoptado de pizarras y confirmado por Martin.'),
 (2,7,N'Relato personal: primeras cuatro noches en el mismo frente. Código LA6 adoptado de pizarras y confirmado por Martin.'),
 (2,8,N'Relato personal: primeras cuatro noches en el mismo frente. Código LA6 adoptado de pizarras y confirmado por Martin.'),
 (2,9,N'Relato personal: primeras cuatro noches en el mismo frente. Resultado parcial referido al período; sin hora de terminación registrada.'),
 (3,6,N'Asociación al período LA6, turnos 6-9. Relato sin desglose diario: no confirma intervención térmica en esta noche ni cantidad de eventos.'),
 (3,7,N'Asociación al período LA6, turnos 6-9. Relato sin desglose diario: no confirma intervención térmica en esta noche ni cantidad de eventos.'),
 (3,8,N'Asociación al período LA6, turnos 6-9. Relato sin desglose diario: no confirma intervención térmica en esta noche ni cantidad de eventos.'),
 (3,9,N'Asociación al período LA6, turnos 6-9. Relato sin desglose diario: no confirma intervención térmica en esta noche ni cantidad de eventos.'),
 (4,10,N'Relato personal: última noche en LC7/RC7. Pizarra rotulada 17/10, A, NS: LC7/RC7 cluster. Turno iniciado el 16/10 y finalizado el 17/10.')
 )v(a,s,b);

 INSERT ops.DependencyObservation(dependency_id,case_id,dependency_type,observation_note)
 VALUES
 (@DependencyBase+1,@CaseId,N'Servicios de grúa',
 N'Según relato personal, se utilizaron servicios de grúa para trasladar segmentos tubulares y recambiar o suministrar cilindros de gases al frente elevado sobre scaffold. Martin menciona argón y oxígeno. No se registraron duraciones, número de maniobras ni tiempos de espera.'),
 (@DependencyBase+2,@CaseId,N'Intervención del heat technician',
 N'El apoyo térmico requería coordinación por radio con el técnico y asistencia para disponer heat pads y recubrimientos. No se documentaron frecuencia por noche, temperaturas, ciclos ni tiempos de espera.'),
 (@DependencyBase+3,@CaseId,N'Protección frente al clima',
 N'El acondicionamiento del frente incluyó brattice para reducir la exposición a lluvia y viento. Las pizarras documentan atención al clima, superficies resbaladizas y herramientas o EPP mojados. No se dispone de duración de interrupciones atribuibles al clima.'),
 (@DependencyBase+4,@CaseId,N'Continuidad entre equipos',
 N'Parte del trabajo en LA6 continuó con otro boilermaker y su TA al trasladarse el equipo de Martin, integrado por dos boilermakers y un TA, a LC7/RC7. No se documentaron horas de relevo ni aceptación formal.'),
 (@DependencyBase+5,@CaseId,N'Inspección posterior a soldadura',
 N'El relato menciona una inspección de fisuras posterior a los trabajos de soldadura y acabado en LB5/RB5. No se confirmó método, fecha, resultado ni aceptación técnica. La terminación observada del trabajo se distingue de su aprobación.');

 INSERT ops.CaseContext(context_id,case_id,topic,context_note)
 VALUES
 (@ContextBase+1,@CaseId,N'Calendario y horarios',
 N'Diez turnos consecutivos: cinco diurnos de 06:30 a 18:30 y cinco nocturnos de 18:30 a 06:30 del día siguiente. Fechas reconstruidas desde el final confirmado del último turno, 17/10/2026 a las 06:30, manteniendo el horario habitual. DS del 07 al 11/10; NS iniciados del 12 al 16/10. Horarios locales del sitio en Queensland. Las fechas escritas en pizarras se conservan como rótulos de la fuente y no sustituyen automáticamente la fecha de inicio del turno.'),
 (@ContextBase+2,@CaseId,N'Fuentes y nomenclatura',
 N'Martin confirmó adoptar la nomenclatura de las pizarras: LB5/RB5 para el período diurno, LA6 para las primeras cuatro noches y LC7/RC7 para la última. Fuentes: IMG_1240.jpeg, 10/10 A DS; IMG_1232(1).jpeg e IMG_1243.jpeg, misma pizarra 11/10 A DS; IMG_1239.jpeg, 13/10 C DS; IMG_1255.jpeg, 14/10 A NS; IMG_1267.jpeg, 15/10 A Night; IMG_1275.jpeg, 16/10 A, turno fuera del encuadre; IMG_1278.jpeg, 17/10 A NS. Ocho fotografías de siete pizarras distintas. La pizarra de Crew C aporta contexto de otra crew.'),
 (@ContextBase+3,@CaseId,N'Organización del equipo',
 N'Martin participó como Trade Assistant. Durante las noches trabajó con dos boilermakers. En LA6 observó terminado uno de los lados, mientras el otro continuó con otro boilermaker y su TA. Su equipo se trasladó a LC7/RC7 para iniciar otro frente en la última noche. No se identificó cuál de los lados de LA6 quedó terminado.'),
 (@ContextBase+4,@CaseId,N'Preparación del puesto',
 N'El apoyo descrito comprendió preparación de soldadoras, grupo electrógeno, cables, consumibles y herramientas, y colocación de brattice contra lluvia y viento sobre el scaffold existente. En el período diurno incluyó sostener reglas y girar tubos para que los tradies tomaran medidas y realizaran el corte. No se atribuyen a Martin soldadura, corte ni operación de amoladoras en este swing.'),
 (@ContextBase+5,@CaseId,N'Clima y housekeeping',
 N'Las pizarras registran housekeeping el 10/10; housekeeping y lead management junto con weather management el 14/10; y preparación para lluvia, herramientas y EPP mojados y superficies resbaladizas el 16/10. Complementan el relato sobre ordenamiento de cables y protección del puesto mediante brattice. Son temas comunicados en prestart, no pruebas de que todos los peligros ocurrieran en el puesto personal.'),
 (@ContextBase+6,@CaseId,N'Trabajos en caliente y herramientas',
 N'Las pizarras comunican peligros y controles de structural: trabajos en caliente, fuego, gases inflamables, proyección de partículas, superficies calientes, herramientas defectuosas, protección ocular, fire watch e inspecciones de herramientas y equipos. El 15/10 se destaca la inspección de herramientas. Se registra el contenido comunicado; no se infiere la ejecución personal de cada control ni una inspección técnica aprobada.'),
 (@ContextBase+7,@CaseId,N'Coordinación y documentación',
 N'Martin describe comunicaciones por radio para coordinar al heat technician, asistencia con heat pads y recubrimientos y participación relacionada con permisos y JSA. Las pizarras incluyen Finish Permits el 11/10 y Radio communications el 17/10. No se atribuye a Martin emisión, firma o autorización de permisos, ni definición de parámetros térmicos. El detalle de su participación documental no fue desglosado.'),
 (@ContextBase+8,@CaseId,N'Alcance y precisión de la evidencia',
 N'Las actividades personales provienen del relato; las pizarras documentan planificación y contexto del shutdown. Sus tareas generales de propel, electricidad, limpieza y scaffold no se contabilizan como actividades personales de Martin. La asociación de asistencia térmica a turnos 6-9 delimita el período posible y no acredita cuatro intervenciones. Tampoco se afirma que cada subtarea diurna ocurriera todos los días. Los resultados observados no equivalen a aceptación técnica. No se dispone de horas productivas, duración de esperas, cantidad de soldaduras ni porcentajes de avance.');

 IF (SELECT COUNT(*) FROM ops.WorkShift WHERE case_id=@CaseId)<>10
  THROW 51002,'Validación fallida: se esperaban 10 turnos.',1;
 IF (SELECT COUNT(*) FROM ops.WorkShift WHERE case_id=@CaseId AND shift_type='DS')<>5
  THROW 51003,'Validación fallida: se esperaban 5 turnos DS.',1;
 IF (SELECT COUNT(*) FROM ops.WorkShift WHERE case_id=@CaseId AND shift_type='NS')<>5
  THROW 51004,'Validación fallida: se esperaban 5 turnos NS.',1;
 IF (SELECT COUNT(*) FROM ops.Activity WHERE case_id=@CaseId)<>4
  THROW 51005,'Validación fallida: se esperaban 4 actividades.',1;
 IF (SELECT COUNT(*) FROM ops.ActivityShift x JOIN ops.Activity a ON a.activity_id=x.activity_id WHERE a.case_id=@CaseId)<>14
  THROW 51006,'Validación fallida: se esperaban 14 asociaciones.',1;
 IF (SELECT COUNT(*) FROM ops.DependencyObservation WHERE case_id=@CaseId)<>5
  THROW 51007,'Validación fallida: se esperaban 5 dependencias.',1;
 IF (SELECT COUNT(*) FROM ops.CaseContext WHERE case_id=@CaseId)<>8
  THROW 51008,'Validación fallida: se esperaban 8 registros de contexto.',1;
 IF EXISTS(SELECT 1 FROM ops.ActivityShift x JOIN ops.Activity a ON a.activity_id=x.activity_id JOIN ops.WorkShift w ON w.shift_id=x.shift_id WHERE (a.case_id=@CaseId OR w.case_id=@CaseId) AND a.case_id<>w.case_id)
  THROW 51009,'Validación fallida: actividad y turno pertenecen a casos diferentes.',1;
 IF EXISTS(SELECT 1 FROM ops.WorkShift w WHERE w.case_id=@CaseId AND NOT EXISTS(SELECT 1 FROM ops.ActivityShift x WHERE x.shift_id=w.shift_id))
  THROW 51010,'Validación fallida: hay un turno sin actividad.',1;
 IF EXISTS(SELECT 1 FROM ops.Activity a WHERE a.case_id=@CaseId AND NOT EXISTS(SELECT 1 FROM ops.ActivityShift x WHERE x.activity_id=a.activity_id))
  THROW 51011,'Validación fallida: hay una actividad sin asociación temporal.',1;
 IF EXISTS(SELECT 1 FROM ops.WorkShift WHERE case_id=@CaseId AND DATEDIFF(SECOND,starts_at,ends_at)<>43200)
  THROW 51012,'Validación fallida: hay un turno que no dura 12 horas.',1;
 COMMIT TRANSACTION;
 PRINT N'OK: Swing 3 cargado y validado.';
END TRY
BEGIN CATCH
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
 THROW;
END CATCH;

SELECT c.case_id,c.case_code,
 (SELECT COUNT(*) FROM ops.WorkShift w WHERE w.case_id=c.case_id) AS turnos,
 (SELECT COUNT(*) FROM ops.Activity a WHERE a.case_id=c.case_id) AS actividades,
 (SELECT COUNT(*) FROM ops.ActivityShift x JOIN ops.Activity a ON a.activity_id=x.activity_id WHERE a.case_id=c.case_id) AS asociaciones,
 (SELECT COUNT(*) FROM ops.DependencyObservation d WHERE d.case_id=c.case_id) AS dependencias,
 (SELECT COUNT(*) FROM ops.CaseContext cx WHERE cx.case_id=c.case_id) AS contextos
FROM ops.ShutdownCase c ORDER BY c.case_id;

SELECT w.swing_shift_number AS turno,w.shift_type,w.starts_at,w.ends_at,a.activity_id,a.area,a.description,a.outcome_note,x.assignment_basis
FROM ops.ShutdownCase c JOIN ops.WorkShift w ON w.case_id=c.case_id
JOIN ops.ActivityShift x ON x.shift_id=w.shift_id JOIN ops.Activity a ON a.activity_id=x.activity_id
WHERE c.case_code=@CaseCode ORDER BY w.swing_shift_number,a.activity_id;
