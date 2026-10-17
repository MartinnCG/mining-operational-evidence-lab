-- Apply after 04_load_rolleston_swing03.sql. Reconstructed from the learning session.
USE MiningLab;
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
 BEGIN TRANSACTION;
 DECLARE @CaseId int;
 SELECT @CaseId=case_id FROM ops.ShutdownCase WHERE case_code='ROL-DL01-A-S03-202610';
 IF @CaseId IS NULL THROW 51101,'No se encontró el swing 3. No se realizaron cambios.',1;
 IF (SELECT COUNT(*) FROM ops.WorkShift WHERE case_id=@CaseId)<>10
  THROW 51102,'El swing 3 no tiene los diez turnos esperados.',1;

 IF COL_LENGTH('ops.WorkShift','operational_summary') IS NULL
  EXEC sys.sp_executesql N'ALTER TABLE ops.WorkShift ADD operational_summary nvarchar(1000) NULL;';

 EXEC sys.sp_executesql N'
 UPDATE w SET operational_summary=v.summary
 FROM ops.WorkShift w
 JOIN(VALUES
 (1,N''Asistencia en LB5/RB5 dentro de la rutina de preparación del frente: disposición de soldadoras, cables y consumibles sobre el scaffold, con cobertura de brattice para proteger el puesto de lluvia y viento. Apoyo al tradie para mantener disponibles los elementos necesarios para trabajar sobre los segmentos tubulares.''),
 (2,N''Apoyo operativo a los boilermakers en LB5/RB5, combinando abastecimiento de herramientas y consumibles con asistencia manual en la presentación de tubos. La rutina descrita incluyó sostener reglas y girar piezas para facilitar la toma de medidas por los tradies, responsables del corte y la soldadura.''),
 (3,N''Trabajo como TA en el frente LB5/RB5: atención a las necesidades de los tradies durante la preparación y montaje de segmentos, acercamiento de elementos y organización del equipo disponible. La intervención del período contó con servicios de grúa para el movimiento de tubos y el suministro o recambio de cilindros.''),
 (4,N''Continuidad de la asistencia en LB5/RB5 durante los trabajos de instalación y soldadura de segmentos indicados en la pizarra del 10/10. Apoyo mediante preparación de equipos, provisión de herramientas y consumibles y ayuda manual para medición y presentación de las piezas.''),
 (5,N''Asistencia al frente LB5/RB5 en el último turno diurno. La planificación del 11/10 mantenía instalación y soldadura de segmentos. Martin recuerda terminado el trabajo del período, incluido el ensamblaje y acabado posterior de los tubos; el resultado de la inspección de fisuras no fue confirmado.''),
 (6,N''Primera noche del período en LA6, como TA de dos boilermakers. La rutina comprendía preparar soldadora y grupo electrógeno, disponer cables y dejar accesibles las herramientas y consumibles necesarios para sostener el trabajo del equipo.''),
 (7,N''Continuidad del apoyo a los boom welders en LA6. Atención a los requerimientos de los dos boilermakers, suministro de consumibles y herramientas y organización del puesto. Durante este período Martin también coordinó por radio y asistió al heat technician, sin identificar la noche exacta de cada intervención.''),
 (8,N''Asistencia operativa en LA6 mediante abastecimiento a los soldadores y disposición de equipos y cables. El apoyo descrito para estas noches incluyó preparar los elementos requeridos por el trabajo y colaborar con heat pads y recubrimientos cuando intervenía el técnico, sin registro diario de frecuencia o parámetros térmicos.''),
 (9,N''Última de las cuatro noches asignadas a LA6. Continuidad del servicio de herramientas y consumibles al equipo. Como resultado del período, Martin observó un lado terminado y otro en continuidad con un boilermaker y su TA; no se registró el momento exacto de ese avance ni una aprobación técnica.''),
 (10,N''Traslado del equipo de dos boilermakers y un TA al frente LC7/RC7 e inicio de una nueva intervención. Preparación del puesto con equipos de soldadura, cables, herramientas y consumibles. Martin finalizó su participación al cierre del turno y no presenció la terminación de este trabajo.'')
 )v(shift_number,summary) ON v.shift_number=w.swing_shift_number
 WHERE w.case_id=@TargetCaseId;
 IF @@ROWCOUNT<>10 THROW 51103,''No se actualizaron los diez resúmenes esperados.'',1;',
 N'@TargetCaseId int',@TargetCaseId=@CaseId;

 UPDATE ops.CaseContext SET context_note=
 N'Los resúmenes de turno son una reconstrucción narrativa supervisada por Martin a partir de rutinas repetidas y períodos de trabajo confirmados. La redacción diferencia el foco de cada registro, pero no afirma que las subtareas mencionadas fueran exclusivas de ese día ni que las omitidas no ocurrieran. La planificación de las pizarras se identifica como tal. La asistencia térmica se conoce para el período LA6, sin frecuencia diaria confirmada. Los resultados observados no equivalen a aceptación técnica. No se dispone de horas productivas, duración de esperas, cantidad de soldaduras ni porcentajes de avance.'
 WHERE case_id=@CaseId AND topic=N'Alcance y precisión de la evidencia';
 IF @@ROWCOUNT<>1 THROW 51104,'No se encontró el contexto de precisión esperado.',1;

 COMMIT TRANSACTION;
 PRINT N'OK: diez turnos con resumen operativo propio.';
END TRY
BEGIN CATCH
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
 THROW;
END CATCH;

EXEC sys.sp_executesql N'
SELECT w.swing_shift_number AS turno,w.shift_type AS tipo,w.starts_at AS inicio,w.ends_at AS fin,w.operational_summary AS resumen_operativo
FROM ops.WorkShift w JOIN ops.ShutdownCase c ON c.case_id=w.case_id
WHERE c.case_code=''ROL-DL01-A-S03-202610''
ORDER BY w.swing_shift_number;';
