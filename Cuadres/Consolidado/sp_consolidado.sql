
/***********************************************************************************************
	Archivo         :	cc_sp_consolidado.sql								
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

if exists (select * from sysobjects where name = 'cc_sp_consolidado')
	drop proc cc_sp_consolidado
go

CREATE PROCEDURE [cc_sp_consolidado]
(	@I_CUENTA	varchar(64)=NULL,
	@I_OFICINA int=NULL,
	@I_FECHA_CORTE DATETIME =NULL,	

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
	@W_SQL_CONT VARCHAR(4000),
	@W_PERIODO INT,
	@W_CORTE INT

  SET @O_ROWS = 0
   
  set @O_PAGES	=1
  set @O_RETVAL	=0
  set @O_RETMSG	=''

  select @W_CORTE=co_corte,@W_PERIODO=co_periodo 
  from cob_conta..cb_corte
  where co_fecha_ini = @I_FECHA_CORTE

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_consolidado: Existe corte ni periodo para la fecha ingresada'
			RETURN @O_RETVAL
		END


		-- MODO 0: CONSULTA DE 

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'bl_cod_oficina,
				(select of_nombre from cobis..cl_oficina where of_oficina = b.bl_oficina)bl_oficina,
                bl_cuenta,
                (select cu_nombre from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = b.bl_cuenta) as bl_cuenta_des,
				(0.0) as bl_saldo_con,
                bl_saldo_tot,
				(0.00)bl_diferencia
	 '
		SET @W_TABLAS = ' FROM cob_conta..cb_balsuper b
				WHERE bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO)
				+' and bl_corte   = '+ CONVERT(VARCHAR,@W_CORTE)
				+' and bl_empresa = 1 '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' AND ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY bl_oficina
'
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		EXECUTE ( @W_SQL )
		--print @W_SQL
		--set @O_RETMSG=@W_SQL
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
