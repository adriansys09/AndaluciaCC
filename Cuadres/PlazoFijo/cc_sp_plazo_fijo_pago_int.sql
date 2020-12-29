
/***********************************************************************************************
	Archivo         :	cc_sp_plazo_fijo_pago_int.sql								
	Diseñado por	:	Cooperativa Andalucia										
	Módulo			:	ProyectoCuadresSQL												
	Descripción	    :	Procedimiento para consulta de Plazo_Fijo_Pago_Int		
																				
***********************************************************************************************
	Este programa es parte del paquete de ProyectoCuadresSQL propiedad			
	de Cooperativa Andalucia.														
	Su uso no autorizado queda expresamente prohibido asi como					
	cualquier alteracion o agregado hecho por alguno de sus						
	usuarios sin el debido consentimiento por escrito de de Cooperativa Andalucia.	
***********************************************************************************************
	Fecha de Escritura:	Ago 31 2020  6:32AM									
	Autor		  :	Ing. Adrian Loya													
***********************************************************************************************
	MODIFICACIONES																
	Fecha		Autor		     Razón											
                                                                              
***********************************************************************************************/

if exists (select * from sysobjects where name = 'cc_sp_plazo_fijo_pago_int')
	drop proc cc_sp_plazo_fijo_pago_int
go

CREATE PROCEDURE [cc_sp_plazo_fijo_pago_int]
(	@I_USUARIO	varchar(64)=NULL,
	@I_TRANSACCION int=NULL,
	@I_CODIGO INT =NULL,	

	----PARÁMETROS PARA PAGINACIÓN
	@I_MODO			TINYINT = NULL,
	@I_FILAS		INT = 100,	
	@I_FILTRO		VARCHAR(2048) = NULL,
	@I_ORDEN		VARCHAR(2048) = NULL,
	@I_PAGINA	    INT = 1,
	
	
    @O_REGISTROS INT OUTPUT
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

  SET @O_REGISTROS = 0


		-- MODO 0: CONSULTA DE UN REGISTRO POR ID
		IF @I_MODO = 0
		BEGIN
			SELECT 
				PI_CODIGO
	,PI_FECHA_PAGO
	,PI_ENTE
	,PI_NUM_BANCO
	,PI_VALOR
	,PI_DESCRIPCION
	,PI_FECHA_EMISION
	,PI_FECHA_VEN
	,PI_FPAGO
	
				
			FROM 
				CC_PLAZO_FIJO_PAGO_INT
			WHERE
				PI_CODIGO = @I_CODIGO


			IF @@ROWCOUNT = 0
			BEGIN
				exec cobis..sp_cerror
				@t_debug	= 'N',
				@t_file		= 'cc_sp_plazo_fijo_pago_int.sql',
				@t_from		= 'cc_sp_plazo_fijo_pago_int.sql',
				@i_num		= 101001

				return 1
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'PI_CODIGO
	,PI_FECHA_PAGO
	,PI_ENTE
	,PI_NUM_BANCO
	,PI_VALOR
	,PI_DESCRIPCION
	,PI_FECHA_EMISION
	,PI_FECHA_VEN
	,PI_FPAGO
	 '
		SET @W_TABLAS = ' FROM CC_PLAZO_FIJO_PAGO_INT '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY PI_CODIGO
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
			exec cobis..sp_cerror
				@t_debug	= 'N',
				@t_file		= 'cc_sp_plazo_fijo_pago_int.sql',
				@t_from		= 'cc_sp_plazo_fijo_pago_int.sql',
				@i_num		= 101001
			RETURN 1
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_REGISTROS = COUNT(*) ' +
								@W_TABLAS + @W_CONDI
			EXEC ( @W_SQL_CONT )
		END
	END
	RETURN 0
END
