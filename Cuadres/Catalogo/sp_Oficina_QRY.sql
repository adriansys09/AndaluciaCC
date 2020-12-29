if exists (select * from sysobjects where name = 'sp_Oficina_QRY')
	drop proc sp_Oficina_QRY
go

CREATE PROCEDURE sp_Oficina_QRY
(	
	@I_USUARIO	varchar(64)=null,
	@I_TRANSACCION int=null,
	@I_OFICINA SMALLINT=null,	
	--@t_trn			smallint = null,
    @i_operacion           	char(1)=null,
    @i_filial              	tinyint=NULL,
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
			SELECT 
				of_filial
	,of_oficina
	,of_nombre
	,of_direccion
	,of_ciudad
	,of_telefono
	,of_subtipo
	,a_sucursal
	,ci_descripcion
				
			FROM cobis..cl_oficina,cobis..cl_ciudad
			WHERE of_oficina= @I_OFICINA
			and ci_ciudad = of_ciudad

			IF @@ROWCOUNT = 0
			BEGIN
				SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_Oficina_QRY: Registro no existe'
				RETURN @O_RETVAL
				--exec @O_RETMSG=cobis..sp_cerror
				--@t_debug	= 'N',
				--@t_file		= '',
				--@t_from		= 'sp_Oficina_QRY',
				--@i_num		= 101001
				--return 1
			END
		END

	-- MODO 1: CONSULTA DE UNA LISTA DE REGISTROS PAGINADA, CON FILTRO Y ORDEN. DINAMICA
	IF @I_MODO = 1
	BEGIN
		SET @W_CAMPOS = 'of_filial
	,of_oficina
	,of_nombre
	,of_direccion
	,of_ciudad
	,of_telefono
	,of_subtipo
	,a_sucursal
	,ci_descripcion
	 '
		SET @W_TABLAS = ' FROM cobis..cl_oficina, cobis..cl_ciudad '
		SET @W_CONDI  = '' 
		IF @I_FILTRO is not NULL SET @W_CONDI = @W_CONDI + ' WHERE ' + @I_FILTRO
		SET @W_ORDEN = ' ORDER BY of_oficina
'
		IF @I_ORDEN is not NULL SET @W_ORDEN = ' ORDER BY ' + @I_ORDEN
		SET @W_SQL =' SELECT ' + @W_CAMPOS + 
					' ' + @W_TABLAS + @W_CONDI +
					' AND of_oficina <= @I_PAGINA * @I_FILAS ' +
					' AND of_oficina > (@I_PAGINA - 1) * @I_FILAS ' + @W_ORDEN 

		EXECUTE ( @W_SQL )
		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @O_RETVAL = -4, @O_RETMSG = 'SQL.10012: sp_Oficina_QRY: Registro no existe'
			RETURN @O_RETVAL
			--exec cobis..sp_cerror
			--	@t_debug	= 'N',
			--	@t_file		= '',
			--	@t_from		= 'sp_Oficina_QRY',
			--	@i_num		= 101001
		END
		ELSE
		BEGIN
			SET @W_SQL_CONT = ' SELECT @O_ROWS = COUNT(*) ' + @W_TABLAS + @W_CONDI
			EXEC ( @W_SQL_CONT )
			SET @O_PAGES=CEILING(CAST( @O_ROWS as decimal)/@I_FILAS)
		END
	END
	RETURN 0
END
