
/***********************************************************************************************
	Archivo         :	sp_producto_cobis_qry.sql								
	Diseñado por	:	Cooperativa Andalucia										
	Módulo			:	ProyectoCuadresSQL												
	Descripción	    :	Procedimiento para consulta de Producto		
																				
***********************************************************************************************
	Este programa es parte del paquete de ProyectoCuadresSQL propiedad			
	de Cooperativa Andalucia.														
	Su uso no autorizado queda expresamente prohibido asi como					
	cualquier alteracion o agregado hecho por alguno de sus						
	usuarios sin el debido consentimiento por escrito de Cooperativa Andalucia	
***********************************************************************************************
	Fecha de Escritura:	Ago 31 2020  9:09PM									
	Autor		  :	Ing. Adrian Loya													
***********************************************************************************************
	MODIFICACIONES																
	Fecha		Autor		     Razón											
                                                                              
***********************************************************************************************/
use anda_reporte
go

if exists (select * from sysobjects where name = 'sp_producto_cobis_qry')
	drop proc sp_producto_cobis_qry
go

CREATE PROCEDURE [sp_producto_cobis_qry]
(	@I_USUARIO	varchar(64)=null,
	@I_TRANSACCION int=null,
	@I_PRODUCTO TINYINT=null,	

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
				pd_producto
	,pd_tipo
	,pd_descripcion
	,pd_abreviatura
	,pd_fecha_apertura
	,pd_estado
	,pd_saldo_minimo
	,pd_costo
	
				
			FROM cobis..cl_producto
			WHERE pd_producto = @I_PRODUCTO


			IF @@ROWCOUNT = 0
			BEGIN
			exec cobis..sp_cerror
				@t_debug	= 'N',
				@t_file		= 'sp_producto_cobis_qry',
				@t_from		= 'sp_producto_cobis_qry',
				@i_num		= 101032
			    /* No existe producto */

				return 1
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
	CREATE TABLE #TABLA(ID_REGISTRO	int	IDENTITY,
	pd_producto tinyint NOT NULL,   
	pd_tipo char(1) NULL,           
	pd_descripcion varchar(64) NULL,
	pd_abreviatura char(3) NULL,    
	pd_fecha_apertura datetime NULL,
	pd_estado char(1) NULL,         
	pd_saldo_minimo money NULL,     
	pd_costo money NULL)

		SET @W_CAMPOS = 'pd_producto
	,pd_tipo
	,pd_descripcion
	,pd_abreviatura
	,pd_fecha_apertura
	,pd_estado
	,pd_saldo_minimo
	,pd_costo
	 '
		SET @W_TABLAS = ' FROM cobis..cl_producto '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY pd_producto
'
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' INSERT INTO #TABLA (pd_producto,pd_tipo,pd_descripcion,pd_abreviatura,pd_fecha_apertura,pd_estado,pd_saldo_minimo,pd_costo)'+
		'SELECT ' + @W_CAMPOS + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			exec cobis..sp_cerror
				@t_debug	= 'N',
				@t_file		= 'sp_producto_cobis_qry',
				@t_from		= 'sp_producto_cobis_qry',
				@i_num		= 101032
			    /* No existe producto */
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
