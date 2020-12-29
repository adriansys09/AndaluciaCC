
/***********************************************************************************************
	Archivo         :	sp_cuenta_qry.sql								
	Diseñado por	:	Cooperativa Andalucia										
	Módulo			:	ProyectoCuadresSQL												
	Descripción	    :	Procedimiento para consulta de Cuenta		
																				
***********************************************************************************************
	Este programa es parte del paquete de ProyectoCuadresSQL propiedad			
	de Cooperativa Andalucia.														
	Su uso no autorizado queda expresamente prohibido asi como					
	cualquier alteracion o agregado hecho por alguno de sus						
	usuarios sin el debido consentimiento por escrito de Cooperativa Andalucia.	
***********************************************************************************************
	Fecha de Escritura:	Sep  2 2020  3:30PM									
	Autor		  :	Ing. Adrian Loya													
***********************************************************************************************
	MODIFICACIONES																
	Fecha		Autor		     Razón											
                                                                              
***********************************************************************************************/

if exists (select * from sysobjects where name = 'sp_cuenta_qry')
	drop proc sp_cuenta_qry
go

CREATE PROCEDURE sp_cuenta_qry
(	
	@I_EMPRESA TINYINT=null,
	@I_CUENTA VARCHAR(34)=null,	

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
			SELECT cu_empresa
			,cu_cuenta
			,cu_cuenta_padre
			,cu_nombre
			,cu_descripcion
			,cu_estado
			,cu_movimiento
			,cu_nivel_cuenta
			,cu_categoria
			,cu_fecha_estado
			,cu_moneda
			,cu_sinonimo

			FROM cob_conta..cb_cuenta
			WHERE cu_empresa = @I_EMPRESA
			AND cu_cuenta = @I_CUENTA

			IF @@ROWCOUNT = 0
			BEGIN
				SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_Oficina_QRY: Registro no existe'
				RETURN @O_RETVAL
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'cu_empresa
	,cu_cuenta
	,cu_cuenta_padre
	,cu_nombre
	,cu_descripcion
	,cu_estado
	,cu_movimiento
	,cu_nivel_cuenta
	,cu_categoria
	,cu_fecha_estado
	,cu_moneda
	,cu_sinonimo
		,(rtrim(cu_cuenta) +'' - '' +rtrim(cu_nombre)) as cu_cuenta_des
	 '
		SET @W_TABLAS = ' FROM cob_conta..cb_cuenta '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY cu_empresa,cu_cuenta '
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_Oficina_QRY: Registro no existe'
			RETURN @O_RETVAL
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
