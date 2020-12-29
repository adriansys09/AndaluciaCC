
/***********************************************************************************************
	Archivo         :	cc_sp_cuadre_contable.sql								
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

if exists (select * from sysobjects where name = 'cc_sp_cuadre_contable')
	drop proc cc_sp_cuadre_contable
go

CREATE PROCEDURE [cc_sp_cuadre_contable]
(	@I_CUENTA	varchar(64)=NULL,
	@I_OFICINA int=NULL,
	@I_FECHA_CORTE DATETIME =NULL,	

	----PARÁMETROS PARA PAGINACIÓN
	@I_MODO			TINYINT = NULL,
	@I_FILAS		INT = 100,	
	@I_FILTRO		VARCHAR(2048) = NULL,
	@I_FILTRO2		VARCHAR(2048) = NULL,
	@I_ORDEN		VARCHAR(2048) = NULL,
	@I_PAGINA	    INT = 1,
	
	@O_ROWS			INT OUTPUT,
	@O_PAGES		INT OUTPUT,
	@O_RETVAL		INT OUTPUT,
	@O_RETMSG		VARCHAR(2048) OUTPUT,
	@O_TOTAL_PROD MONEY OUTPUT,
	@O_TOTAL_CONT MONEY OUTPUT,
	@O_TOTAL_DIF MONEY OUTPUT

)
AS
BEGIN
DECLARE
	-- VARIABLES DE PAGINACIÓN
    @W_CAMPOS	VARCHAR(4000),
	@W_TABLAS	VARCHAR(4000),
	@W_CONDI	VARCHAR(4000),
	@W_ORDEN	VARCHAR(512),
	@W_SQL		VARCHAR(8000),
	@W_SQL_CONT VARCHAR(8000),
	@W_PERIODO INT,
	@W_CORTE INT,
	@W_SQL_COUNT VARCHAR(8000),
	@cnt int,
	 @W_CAMPOS2	VARCHAR(4000),
	@W_TABLAS2	VARCHAR(4000),
	@W_CONDI2	VARCHAR(4000),
	@W_ORDEN2	VARCHAR(512),
	@w_Union varchar(8000)
	
	
  SET @O_ROWS = 0
   
  set @O_PAGES	=1
  set @O_RETVAL	=0
  set @O_RETMSG	=''
  SET @O_TOTAL_PROD=0
  SET @O_TOTAL_CONT=0
  SET @O_TOTAL_DIF =0

  select @W_CORTE=co_corte,@W_PERIODO=co_periodo 
  from cob_conta..cb_corte
  where co_fecha_ini = @I_FECHA_CORTE

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_cuadre_contable: Existe corte ni periodo para la fecha ingresada'
			RETURN @O_RETVAL
		END
		

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA 2101,210
	IF @I_MODO = 1
	BEGIN
	
		SET @W_CAMPOS = 'rf_cod_oficina,
	rf_oficina,
	rf_cuenta as rf_Cuenta,
	(select rtrim(cu_nombre) from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = rp.rf_cuenta)rf_CuentaDes,
	SUM(rf_cuota_capital) rf_saldo_consolidado,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = rp.rf_cuenta)),0.00)rf_Saldo_Tot_Contable,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = rp.rf_cuenta)) ,0.00) - isnull(SUM(rf_cuota_capital),0.00)rf_diferencia '
		SET @W_TABLAS = ' from anda_reporte..rep_cuadre_pasivas rp '
				
				
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' where ' + @I_FILTRO
		SET @W_ORDEN = ' group by rf_cod_oficina,rf_oficina,rf_cuenta ORDER BY rf_cod_oficina,rf_oficina,rf_cuenta '
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		--SET @W_SQL_COUNT='SELECT @cnt=count(*) from ('+@W_SQL +') as T'
			
		
		EXECUTE ( @W_SQL )
		--execute (@W_SQL_COUNT)
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_cuadre_contable: Registro no existe'
			RETURN @O_RETVAL
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*), @O_TOTAL_PROD=SUM(rf_saldo_consolidado),@O_TOTAL_CONT=SUM(rf_Saldo_Tot_Contable),@O_TOTAL_DIF=SUM(rf_diferencia)  from ( select	' +@W_CAMPOS + @W_TABLAS + @W_CONDI+ ' group by rf_cod_oficina,rf_oficina,rf_cuenta )as t' 

			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
			select @O_TOTAL_PROD,@O_TOTAL_CONT,@O_TOTAL_DIF 
		END
	END

	-- MODO 2: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA cambio en el groupby 2105
	IF @I_MODO = 2
	BEGIN
		SET @W_CAMPOS = 'rf_cod_oficina,
	rf_oficina,
	substring(rp.rf_cuenta, 1,4)rf_Cuenta,
	(select rtrim(cu_nombre) from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = substring(rp.rf_cuenta, 1,4))rf_CuentaDes,
	SUM(rf_cuota_capital) rf_saldo_consolidado,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = substring(rp.rf_cuenta, 1,4))),0.00)rf_Saldo_Tot_Contable,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = substring(rp.rf_cuenta, 1,4))),0.00) - isnull(SUM(rf_cuota_capital),0.00)rf_diferencia '
		SET @W_TABLAS = ' from anda_reporte..rep_cuadre_pasivas rp '
				
				
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' where ' + @I_FILTRO
		SET @W_ORDEN = ' group by rf_cod_oficina,rf_oficina,substring(rf_cuenta, 1,4) ORDER BY rf_cod_oficina,rf_oficina,substring(rf_cuenta, 1,4) '
	
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		--SET @W_SQL_COUNT='SELECT @cnt=count(*) from ('+@W_SQL +') as T'
			
		
		EXECUTE ( @W_SQL )
		--execute (@W_SQL_COUNT)
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_cuadre_contable: Registro no existe'
			RETURN @O_RETVAL
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*), @O_TOTAL_PROD=SUM(rf_saldo_consolidado),@O_TOTAL_CONT=SUM(rf_Saldo_Tot_Contable),@O_TOTAL_DIF=SUM(rf_diferencia) from ( select	' +@W_CAMPOS + @W_TABLAS + @W_CONDI+ ' group by rf_cod_oficina,rf_oficina,substring(rf_cuenta, 1,4) ) as t' 

			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
			select @O_TOTAL_PROD,@O_TOTAL_CONT,@O_TOTAL_DIF 
		END		   
	END			   

	-- MODO 3: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA CONSOLIDADOS 2101 YDEMAS CONSOLIDADO
	IF @I_MODO = 3
	BEGIN
		SET @W_CAMPOS = ' 255 as rf_cod_oficina,
	''CONSOLIDADO''rf_oficina,
	rf_cuenta as rf_Cuenta,
	(select rtrim(cu_nombre) from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = rp.rf_cuenta)rf_CuentaDes,
	SUM(rf_cuota_capital) rf_saldo_consolidado,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = 255 and bl_cuenta = rp.rf_cuenta)),0.00)rf_Saldo_Tot_Contable,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = 255 and bl_cuenta = rp.rf_cuenta)),0.00) - isnull(SUM(rf_cuota_capital),0.00)rf_diferencia '
		SET @W_TABLAS = ' from anda_reporte..rep_cuadre_pasivas rp '
				
				
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' where ' + @I_FILTRO
		SET @W_ORDEN = ' group by rf_cuenta ORDER BY rf_cuenta '
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		--SET @W_SQL_COUNT='SELECT @cnt=count(*) from ('+@W_SQL +') as T'
			
		
		EXECUTE ( @W_SQL )
		--execute (@W_SQL_COUNT)
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_cuadre_contable: Registro no existe'
			RETURN @O_RETVAL
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*), @O_TOTAL_PROD=SUM(rf_saldo_consolidado),@O_TOTAL_CONT=SUM(rf_Saldo_Tot_Contable),@O_TOTAL_DIF=SUM(rf_diferencia)  from ( select	' +@W_CAMPOS + @W_TABLAS + @W_CONDI+ ' group by rf_cuenta )as t' 

			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
			select @O_TOTAL_PROD,@O_TOTAL_CONT,@O_TOTAL_DIF 
		END
	END

	-- MODO 4: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA CONSOLIDADO 2105
	IF @I_MODO = 49
	BEGIN
		SET @W_CAMPOS = '255 as rf_cod_oficina,
	''CONSOLIDADO'' as rf_oficina,
	substring(rp.rf_cuenta, 1,4) as rf_Cuenta,
	(select rtrim(cu_nombre) from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = substring(rp.rf_cuenta, 1,4))rf_CuentaDes,
	SUM(rf_cuota_capital) rf_saldo_consolidado,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = 255 and bl_cuenta = substring(rp.rf_cuenta, 1,4))),0.00)rf_Saldo_Tot_Contable,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = 255 and bl_cuenta = substring(rp.rf_cuenta, 1,4))),0.00) - isnull(SUM(rf_cuota_capital),0.00)rf_diferencia '
		SET @W_TABLAS = ' from anda_reporte..rep_cuadre_pasivas rp '
				
				
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' where ' + @I_FILTRO
		SET @W_ORDEN = ' group by  substring(rp.rf_cuenta, 1,4) ORDER BY substring(rp.rf_cuenta, 1,4) '
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		
		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' +
					' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		--SET @W_SQL_COUNT='SELECT @cnt=count(*) from ('+@W_SQL +') as T'
			
		
		EXECUTE ( @W_SQL )
		--execute (@W_SQL_COUNT)
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_cuadre_contable: Registro no existe'
			RETURN @O_RETVAL
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*), @O_TOTAL_PROD=SUM(rf_saldo_consolidado),@O_TOTAL_CONT=SUM(rf_Saldo_Tot_Contable),@O_TOTAL_DIF=SUM(rf_diferencia)  from ( select	' +@W_CAMPOS + @W_TABLAS + @W_CONDI+ ' group by substring(rp.rf_cuenta, 1,4) )as t' 

			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
			select @O_TOTAL_PROD,@O_TOTAL_CONT,@O_TOTAL_DIF 
		END
	END

	-- MODO 5: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA TODOS INCLUIDO 2105
	IF @I_MODO = 5
	BEGIN
		if exists (select * from sysobjects where name='tmp_tabla1')
		begin
			drop table anda_reporte..tmp_tabla1
		end

		create table tmp_tabla1(ID_REGISTRO int IDENTITY,
		rf_cod_oficina int null,
		rf_oficina varchar(255)null,
		rf_Cuenta varchar(64)null,
		rf_CuentaDes varchar(255) null,
		rf_saldo_consolidado money null,
		rf_Saldo_Tot_Contable money null,
		rf_diferencia money null)


		SET @W_CAMPOS = 'rf_cod_oficina,
	rf_oficina,
	substring(rp.rf_cuenta, 1,4)rf_cuenta,
	(select rtrim(cu_nombre) from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = substring(rp.rf_cuenta, 1,4))rf_CuentaDes,
	SUM(rf_cuota_capital) rf_saldo_consolidado,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = substring(rp.rf_cuenta, 1,4))),0.00)rf_Saldo_Tot_Contable,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = substring(rp.rf_cuenta, 1,4))),0.00) - isnull(SUM(rf_cuota_capital),0.00)rf_diferencia '
		SET @W_TABLAS = ' from anda_reporte..rep_cuadre_pasivas rp '
				
				
		SET @W_CONDI  = '' 
		IF @I_FILTRO2 is not NULL SET @W_CONDI = @W_CONDI + ' where '+ @I_FILTRO2
		SET @W_ORDEN = ' group by rf_cod_oficina,rf_oficina,rf_cuenta ORDER BY rf_cod_oficina,rf_oficina,rf_cuenta 	'
	
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		
		SET @W_CAMPOS2 = 'rf_cod_oficina,
	rf_oficina,
	rf_cuenta,
	(select rtrim(cu_nombre) from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta = rp.rf_cuenta)rf_CuentaDes,
	SUM(rf_cuota_capital) rf_saldo_consolidado,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = rp.rf_cuenta)),0.00)rf_Saldo_Tot_Contable,
	isnull(abs((select	sum(bl_saldo_tot) from cob_conta..cb_balsuper where bl_periodo = '+ CONVERT(VARCHAR,@W_PERIODO) +' and bl_corte = '+ CONVERT(VARCHAR,@W_CORTE) +' and bl_empresa = 1 and bl_oficina = rp.rf_cod_oficina and bl_cuenta = rp.rf_cuenta)),0.00) - isnull(SUM(rf_cuota_capital),0.00)rf_diferencia '
		SET @W_TABLAS2 = ' from anda_reporte..rep_cuadre_pasivas rp '
				
				
		SET @W_CONDI2  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI2 = @W_CONDI2 + ' where ' + @I_FILTRO
		SET @W_ORDEN2 = ' group by rf_cod_oficina,rf_oficina,substring(rf_cuenta, 1,4) ORDER BY rf_cod_oficina,rf_oficina,substring(rf_cuenta, 1,4) '
		
		
		--print 'antes union'
		set @w_Union='insert into tmp_tabla1(rf_cod_oficina,rf_oficina,rf_Cuenta,rf_CuentaDes,rf_saldo_consolidado,rf_Saldo_Tot_Contable,rf_diferencia) ( select '+@W_CAMPOS2 +' ' + @W_TABLAS2 +' '+ @W_CONDI2 +' group by rf_cod_oficina,rf_oficina,rf_cuenta ) union all (select '+@W_CAMPOS +' '+  @W_TABLAS +' '+  @W_CONDI +' group by rf_cod_oficina,rf_oficina,substring(rf_cuenta, 1,4))' 
		
		EXECUTE ( @w_Union )
		
		SET @W_SQL =' select ID_REGISTRO,rf_cod_oficina,rf_oficina,rf_Cuenta,rf_CuentaDes,rf_saldo_consolidado,rf_Saldo_Tot_Contable,rf_diferencia from tmp_tabla1'+
					 ' WHERE ID_REGISTRO <= @I_PAGINA * @I_FILAS ' +
					' AND ID_REGISTRO > (@I_PAGINA - 1) * @I_FILAS '
		--SET @W_SQL_COUNT='SELECT @cnt=count(*) from ('+@W_SQL +') as T'
			
		
		EXECUTE ( @W_SQL )
		--execute (@W_SQL_COUNT)
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: cc_sp_cuadre_contable: Registro no existe'
			RETURN @O_RETVAL
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*), @O_TOTAL_PROD=SUM(rf_saldo_consolidado),@O_TOTAL_CONT=SUM(rf_Saldo_Tot_Contable),@O_TOTAL_DIF=SUM(rf_diferencia) from tmp_tabla1' 

			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
			select @O_TOTAL_PROD,@O_TOTAL_CONT,@O_TOTAL_DIF 
		END		
	END			
	RETURN 0
END
