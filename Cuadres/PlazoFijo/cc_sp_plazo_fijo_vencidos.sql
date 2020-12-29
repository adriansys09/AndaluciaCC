
/***********************************************************************************************
	Archivo         :	cc_sp_plazo_fijo_vencidos.sql								
	Diseñado por	:	Cooperativa Andalucia										
	Módulo			:	ProyectoCuadresSQL												
	Descripción	    :	Procedimiento para consulta de Plazo_Fijo_Vencidos		
																				
***********************************************************************************************
	Este programa es parte del paquete de ProyectoCuadresSQL propiedad			
	de Cooperativa Andalucia.														
	Su uso no autorizado queda expresamente prohibido asi como					
	cualquier alteracion o agregado hecho por alguno de sus						
	usuarios sin el debido consentimiento por escrito de Cooperativa Andalucia
***********************************************************************************************
	Fecha de Escritura:	Ago 31 2020  6:17AM									
	Autor		  :	Ing. Adrian Loya													
***********************************************************************************************
	MODIFICACIONES																
	Fecha		Autor		     Razón											
                                                                              
***********************************************************************************************/

if exists (select * from sysobjects where name = 'cc_sp_plazo_fijo_vencidos')
	drop proc cc_sp_plazo_fijo_vencidos
go

CREATE PROCEDURE [cc_sp_plazo_fijo_vencidos]
(	@I_USUARIO	varchar(64)=null,
	@I_TRANSACCION int=null,
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
	@O_RETMSG		VARCHAR(2048) OUTPUT

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
			SELECT PV_CODIGO,				
	PV_OFICINA
	,PV_NUM_BANCO
	,PV_ENTE
	,PV_DESCRIPCION
	,PV_OFICIAL
	,PV_FECHA_VALOR
	,PV_NUM_DIAS
	,PV_FECHA_VEN
	,PV_TASA
	,PV_MONTO
	,PV_TOTAL_INT_ESTIMADO
	,PV_TOTAL_INT_ESTIMADO_PFI
	,PV_TELEFONO
	,PV_TOTAL_INT_PAGADOS
	
				
			FROM CC_PLAZO_FIJO_VENCIDOS
			WHERE PV_CODIGO = @I_CODIGO


			IF @@ROWCOUNT = 0
			BEGIN
				--exec cobis..sp_cerror
				--@t_debug	= 'N',
				--@t_file		= 'cc_sp_plazo_fijo_vencidos.sql',
				--@t_from		= 'cc_sp_plazo_fijo_vencidos',
				--@i_num		= 101001

				--return 1
				SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_plazo_fijo_vencidos: Registro no existe'
				RETURN @O_RETVAL
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'PV_CODIGO,
	PV_OFICINA
	,PV_NUM_BANCO
	,PV_ENTE
	,PV_DESCRIPCION
	,PV_OFICIAL
	,PV_FECHA_VALOR
	,PV_NUM_DIAS
	,PV_FECHA_VEN
	,PV_TASA
	,PV_MONTO
	,PV_TOTAL_INT_ESTIMADO
	,PV_TOTAL_INT_ESTIMADO_PFI
	,PV_TELEFONO
	,PV_TOTAL_INT_PAGADOS
	 '
		SET @W_TABLAS = ' FROM CC_PLAZO_FIJO_VENCIDOS '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY PV_CODIGO
'
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT  ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE PV_CODIGO <= @I_PAGINA * @I_FILAS ' +
					' AND PV_CODIGO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			--exec cobis..sp_cerror
			--	@t_debug	= 'N',
			--	@t_file		= 'cc_sp_plazo_fijo_vencidos.sql',
			--	@t_from		= 'cc_sp_plazo_fijo_vencidos',
			--	@i_num		= 101001

			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_plazo_fijo_vencidos: Registro no existe'
			RETURN @O_RETVAL
		--RETURN 1
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*) ' +
								@W_TABLAS + @W_CONDI
			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
		END
	END
	RETURN 0
END
