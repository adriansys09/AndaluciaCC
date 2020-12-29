/***********************************************************************************************
	Archivo         :	Correo_Aplicacion_QRY.sql								
	Diseñado por	:	Coorepatriva Andalucia CIA LTDA										
	Módulo			:	ProyectoAndaluciaSvc												
	Descripción	    :	Procedimiento para consulta de Correo_Aplicacion		
																				
***********************************************************************************************
	Este programa es parte del paquete de ProyectoAndaluciaSvc propiedad de Coorepatriva Andalucia Cia Ltda.														
	Su uso no autorizado queda expresamente prohibido asi como					
	cualquier alteracion o agregado hecho por alguno de sus						
	usuarios sin el debido consentimiento por escrito de Coorepatriva Andalucia Cía. Ltda.	
***********************************************************************************************
	Fecha de Escritura:	Sep 24 2020 11:01PM									
	Autor		  :	Ing. Adrian Loya													
***********************************************************************************************
	MODIFICACIONES																
	Fecha		Autor		     Razón											
                                                                              
***********************************************************************************************/
if exists (select * from sysobjects where name = 'CORREOAPLICACION_QRY')
	drop proc CORREOAPLICACION_QRY
go

CREATE PROCEDURE [CORREOAPLICACION_QRY]
(	
	@I_CODIGO INT=null,	

	----PARÁMETROS PARA PAGINACIÓN
	@I_MODO			TINYINT = NULL,
	@I_FILAS		INT = 100,	
	@I_FILTRO		VARCHAR(2048) = NULL,
	@I_ORDEN		VARCHAR(2048) = NULL,
	@I_PAGINA	    INT = 1,
	
	@O_ROWS			INT OUTPUT,
	@O_PAGES		INT OUTPUT,
    @O_RETVAL		INT OUTPUT,
	@O_RETMSG		VARCHAR(3000) OUTPUT	
)
AS
BEGIN
DECLARE
	-- VARIABLES DE PAGINACIÓN
    @W_CAMPOS	VARCHAR(512),
	@W_TABLAS	VARCHAR(512),
	@W_CONDI	VARCHAR(512),
	@W_ORDEN	VARCHAR(512),
	@W_SQL		VARCHAR(4000),
	@W_SQL_CONT VARCHAR(4000)

   SET @O_ROWS = 0
  set @O_PAGES	=1
  set @O_RETVAL	=0
  set @O_RETMSG	=''



		-- MODO 0: CONSULTA DE UN REGISTRO POR ID
		IF @I_MODO = 0
		BEGIN
			SELECT 
				CA_CODIGO
	,CA_CODIGO_APLICACION
	,CA_USER_ORIGEN
	,CA_CLAVE_ORIGEN
	,CA_SMTP_SERVER
	,CA_SMTP_SERVER_PORT
	,CA_SMTP_SERVER_SSL
	,CA_PLANTILLAHTML
	,CA_LOGOTIPO
	,CA_FIRMA
	,CA_DESTINO
			FROM 
				CO_CORREO_APLICACION
			WHERE
				CA_CODIGO = @I_CODIGO


			IF @@ROWCOUNT = 0
			BEGIN
				SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: Correo_Aplicacion_QRY: Registro no existe'
				RETURN @O_RETVAL
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'CA_CODIGO
	,CA_CODIGO_APLICACION
	,CA_USER_ORIGEN
	,CA_CLAVE_ORIGEN
	,CA_SMTP_SERVER
	,CA_SMTP_SERVER_PORT
	,CA_SMTP_SERVER_SSL
	,CA_PLANTILLAHTML
	,CA_LOGOTIPO
	,CA_FIRMA
	,CA_DESTINO '

		SET @W_TABLAS = ' FROM CO_CORREO_APLICACION '
		SET @W_CONDI  = ' inner join CO_APLICACION on AP_CODIGO = CA_CODIGO_APLICACION ' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY CA_CODIGO
'
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
		SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: Correo_Aplicacion_QRY: Registro no existe'
				RETURN @O_RETVAL
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS= COUNT(*) ' +@W_TABLAS + @W_CONDI
			EXEC ( @W_SQL_CONT )
		END
	END
	RETURN 0
END
