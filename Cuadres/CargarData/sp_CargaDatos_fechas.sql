if exists (select * from sysobjects where name = 'sp_cc_carga_datos_fechas')
	drop proc sp_cc_carga_datos_fechas
go

CREATE PROCEDURE sp_cc_carga_datos_fechas
(
	@I_MODO			TINYINT = NULL,
	@I_FILTRO		VARCHAR(2048) = NULL,

	--retorno 
	@o_fecha_sd		datetime OUTPUT,
	@o_fecha_cierre	datetime OUTPUT,
	@O_RETVAL		INT OUTPUT,
	@O_RETMSG		VARCHAR(3000) OUTPUT	
)as
begin

declare  @W_CAMPOS	VARCHAR(4000),
	@W_TABLAS	VARCHAR(4000),
	@W_CONDI	VARCHAR(4000),
	@W_ORDEN	VARCHAR(512),
	@W_SQL		VARCHAR(8000),
	@W_SQL_CONT VARCHAR(8000)

set @o_fecha_sd=null
set @o_fecha_cierre	=null
set @O_RETVAL =0
set @O_RETMSG =''

	IF @I_MODO=0
	BEGIN 
	-- FECHA SALDO DIARIO
		SELECT @o_fecha_sd=MAX(sd_fecha) 
		from cob_ahorros_his..ah_saldo_diario 

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_cc_carga_datos_fechas: Registro fecha Saldo diario cob_ahorros_his..ah_saldo_diario no existe.'
			RETURN @O_RETVAL
		END
		--fecha de anda_bi..anda_fecha_cob
		select  @o_fecha_cierre	 =afc_fecha_cierre 
		from anda_bi..anda_fecha_cob

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_cc_carga_datos_fechas: Registro fecha Cierre anda_bi..anda_fecha_cob no existe.'
			RETURN @O_RETVAL
		END
		--select @o_fecha_sd,@o_fecha_cierre	 
	END 
	
	IF @I_MODO=1
	BEGIN 
		SET @W_CAMPOS=' df_ciudad,df_fecha '
		SET @W_TABLAS=' from cobis..cl_dias_feriados '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' where ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY df_fecha '

		SET @W_SQL =' SELECT ID_REGISTRO=IDENTITY(10), ' + @W_CAMPOS + 
					' INTO #TABLA ' + @W_TABLAS + @W_CONDI + @W_ORDEN +
					' SELECT * FROM #TABLA ' 
					

		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_cc_carga_datos_fechas: Modo 1 Registro dias no habiles no existen'
			RETURN @O_RETVAL
		END
	END
	RETURN 0
END