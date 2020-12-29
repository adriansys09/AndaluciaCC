use
andal_aplica
go

if exists (select * from sysobjects where name = 'uc1_familia_qry')
	drop proc uc1_familia_qry
go


/***********************************************************************************************
	Archivo         :	uc1_familia_qry.sql								
	Diseñado por	:	Cooperativa Andalucia Ltda										
	Módulo			:	UC1												
	Descripción	    :	Procedimiento para consulta de ucl_Familia		
																				
***********************************************************************************************
	Este programa es parte del paquete de UC1 propiedad de Cooperativa Andalucia Ltda.														
	Su uso no autorizado queda expresamente prohibido asi como					
	cualquier alteracion o agregado hecho por alguno de sus						
	usuarios sin el debido consentimiento por escrito de Cooperativa Andalucia Ltda	
***********************************************************************************************
	Fecha de Escritura:	Nov 12 2020  3:02PM									
	Autor		  :	Adrian Loya													
***********************************************************************************************
	MODIFICACIONES																
	Fecha		Autor		     Razón											
                                                                              
***********************************************************************************************/
CREATE PROCEDURE [uc1_familia_qry]
(
	@I_ENTE INT=NULL,
	@I_FECHA DATETIME=NULL,	

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
    @W_CAMPOS	VARCHAR(4000),
	@W_TABLAS	VARCHAR(4000),
	@W_CONDI	VARCHAR(4000),
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
				ufa_ente,
				ufa_fecha,
				ufa_cedula,
				ufa_p_apellido,
				ufa_s_apellido,
				ufa_nombre,
				(case f.ufa_parentesco
				when 'CUCH'
				then (select  valor + ' POR PARTE DE MIS HERMANOS' from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cl_parentesco' and c.codigo = substring(f.ufa_parentesco, 1,2))
				when 'CUHC'
				then (select  valor + ' POR PARTE DE MI CONYUGE' from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cl_parentesco' and c.codigo = substring(f.ufa_parentesco, 1, 2))
				else (select  valor from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cl_parentesco' and c.codigo = f.ufa_parentesco)
				end)ufa_parentesco,
				(case f.ufa_discapacidad when 'S' then 'SI' when 'N' then 'NO' else 'N/D' end)ufa_discapacidad,
				convert(varchar(10), convert(datetime, ufa_fecha_nacimiento), 101)ufa_fecha_nacimiento,
				(case f.ufa_mantiene_productos when 'S' then 'SI' when 'N' then 'NO' else '' end)ufa_mantiene_productos,
				(case f.ufa_labora_andalucia when 'S' then 'SI' when 'N' then 'NO' else '' end)ufa_labora_andalucia,
				ufa_estado_vivo,
				isnull(convert(int,(datediff(dd,ufa_fecha_nacimiento,getdate())/365)),0)ufa_edad,
				ufa_referencia,
				ufa_telefono,
				ufa_direccion,
				ufa_fecha_actualiza,
				ufa_usuario_actualiza,
				ufa_estado
			FROM andal_aplica..uc1_familia f
			WHERE ufa_ente = @I_ENTE
			AND ufa_fecha = @I_FECHA


			IF @@ROWCOUNT = 0
			BEGIN
				SELECT @O_RETVAL = -1, @O_RETMSG = 'SQL.10012: FAMILIA_QRY: Registro no existe'
      		    return @O_RETVAL 
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'ufa_ente,
				ufa_fecha,
				ufa_cedula,
				ufa_p_apellido,
				ufa_s_apellido,
				ufa_nombre,
				(case f.ufa_parentesco
				when ''CUCH''
				then (select  valor + '' POR PARTE DE MIS HERMANOS'' from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = ''cl_parentesco'' and c.codigo = substring(f.ufa_parentesco, 1,2))
				when ''CUHC''
				then (select  valor + '' POR PARTE DE MI CONYUGE'' from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = ''cl_parentesco'' and c.codigo = substring(f.ufa_parentesco, 1, 2))
				else (select  valor from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = ''cl_parentesco'' and c.codigo = f.ufa_parentesco)
				end)ufa_parentesco,
				(case f.ufa_discapacidad when ''S'' then ''SI'' when ''N'' then ''NO'' else ''N/D'' end)ufa_discapacidad,
				convert(varchar(10), convert(datetime, ufa_fecha_nacimiento), 101)ufa_fecha_nacimiento,
				(case f.ufa_mantiene_productos when ''S'' then ''SI'' when ''N'' then ''NO'' else '''' end)ufa_mantiene_productos,
				(case f.ufa_labora_andalucia when ''S'' then ''SI'' when ''N'' then ''NO'' else '''' end)ufa_labora_andalucia,
				ufa_estado_vivo,
				isnull(convert(int,(datediff(dd,ufa_fecha_nacimiento,getdate())/365)),0)ufa_edad,
				ufa_referencia,
				ufa_telefono,
				ufa_direccion,
				ufa_fecha_actualiza,
				ufa_usuario_actualiza,
				ufa_estado '
		SET @W_TABLAS = ' from andal_aplica..uc1_familia f '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		if (@I_ORDEN is null)
		begin 
			SET @W_ORDEN = ' ORDER BY ufa_ente,ufa_fecha ' 
		end 
		else
		begin 
			SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN + ' '
		end 

		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -1, @O_RETMSG = 'SQL.10012: FAMILIA_QRY: Registro no existe'
      		    return @O_RETVAL 
		END
		ELSE
		BEGIN
            SET @W_SQL_CONT = ' SELECT @O_ROWS= COUNT(*) ' +@W_TABLAS + @W_CONDI
			EXEC ( @W_SQL_CONT )
		END
	END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'ufa_ente,
				ufa_fecha,
				ufa_cedula,
				ufa_p_apellido,
				ufa_s_apellido,
				ufa_nombre,
				(case f.ufa_parentesco
				when ''CUCH''
				then (select  valor + '' POR PARTE DE MIS HERMANOS'' from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = ''cl_parentesco'' and c.codigo = substring(f.ufa_parentesco, 1,2))
				when ''CUHC''
				then (select  valor + '' POR PARTE DE MI CONYUGE'' from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = ''cl_parentesco'' and c.codigo = substring(f.ufa_parentesco, 1, 2))
				else (select  valor from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = ''cl_parentesco'' and c.codigo = f.ufa_parentesco)
				end)ufa_parentesco,
				(case f.ufa_discapacidad when ''S'' then ''SI'' when ''N'' then ''NO'' else ''N/D'' end)ufa_discapacidad,
				convert(varchar(10), convert(datetime, ufa_fecha_nacimiento), 101)ufa_fecha_nacimiento,
				(case f.ufa_mantiene_productos when ''S'' then ''SI'' when ''N'' then ''NO'' else '''' end)ufa_mantiene_productos,
				(case f.ufa_labora_andalucia when ''S'' then ''SI'' when ''N'' then ''NO'' else '''' end)ufa_labora_andalucia,
				ufa_estado_vivo,
				isnull(convert(int,(datediff(dd,ufa_fecha_nacimiento,getdate())/365)),0)ufa_edad,
				ufa_referencia,
				ufa_telefono,
				ufa_direccion,
				ufa_fecha_actualiza,
				ufa_usuario_actualiza,
				ufa_estado '
		SET @W_TABLAS = ' from andal_aplica..uc1_familia f '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		if (@I_ORDEN is null)
		begin 
			SET @W_ORDEN = ' ORDER BY ufa_ente,ufa_fecha ' 
		end 
		else
		begin 
			SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN + ' '
		end 

		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -1, @O_RETMSG = 'SQL.10012: FAMILIA_QRY: Registro no existe'
      		    return @O_RETVAL 
		END
		ELSE
		BEGIN
            SET @W_SQL_CONT = ' SELECT @O_ROWS= COUNT(*) ' +@W_TABLAS + @W_CONDI
			EXEC ( @W_SQL_CONT )
		END
	END
	RETURN 0
END
