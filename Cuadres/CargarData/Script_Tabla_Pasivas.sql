use anda_reporte
go

IF OBJECT_ID ('dbo.rep_riesgo_reloj') IS NOT NULL
	DROP TABLE dbo.rep_riesgo_reloj
GO

CREATE TABLE dbo.rep_riesgo_reloj
	(
	  re_sec   INT NOT NULL
	, re_fecha DATETIME NOT NULL
	)
	LOCK ALLPAGES
	WITH EXP_ROW_SIZE = 1
	ON 'default'
GO


IF OBJECT_ID ('dbo.rep_cuadre_pasivas') IS NOT NULL
	DROP TABLE dbo.rep_cuadre_pasivas
GO

CREATE TABLE dbo.rep_cuadre_pasivas
	(
	  rf_fecha_carga    DATETIME NULL
	, rf_cuenta         VARCHAR (13) NULL
	, rf_producto       VARCHAR (20) NULL
	, rf_tasa_base      VARCHAR (13) NULL
	, rf_identificacion VARCHAR (13) NULL
	, rf_cliente        INT NULL
	, rf_activo_pasivo  VARCHAR (13) NULL
	, rf_calificacion   VARCHAR (1) NULL
	, rf_moneda         VARCHAR (3) NULL
	, rf_fecha_emision  DATETIME NULL
	, rf_fecha_reprecio DATETIME NULL
	, rf_fecha_vcto     DATETIME NULL
	, rf_cuota_capital  MONEY NULL
	, rf_valor_interes  MONEY NULL
	, rf_valor_comision MONEY NULL
	, rf_cuota_total    MONEY NULL
	, rf_tasa_interes   MONEY NULL
	, rf_base_periodo   INT NULL
	, rf_clase_oper     VARCHAR (15) NULL
	, rf_frecuencia     VARCHAR (60) NULL
	, rf_tdiv_revision  MONEY NULL
	, rf_entidad        VARCHAR (30) NULL
	, rf_oficina        VARCHAR (30) NULL
	, rf_tipo_vcto      INT NULL
	, rf_sensible       VARCHAR (1) NULL
	, rf_desglosado     INT NULL
	, rf_tasa_fija_var  VARCHAR (50) NULL
	, rf_numero_cuotas  INT NULL
	, rf_dias_reprecio  INT NULL
	, rf_dias_vcto      INT NULL
	, rf_operacion      VARCHAR (30) NULL
	, rf_cod_entidad    INT NULL
	, rf_cod_oficina    INT NULL
	, rf_nombre         VARCHAR (100) NULL
	, rf_dividendo      SMALLINT NULL
	, rf_tipo_cca       VARCHAR (10) NULL
	, rf_tipo_persona   VARCHAR (3) NULL
	, rf_tipo_empresa   VARCHAR (3) NULL
	, rf_debito         MONEY NULL
	, rf_credito        MONEY NULL
	, rf_tipo_cliente   INT NULL
	, rf_prod_cobis     TINYINT NULL
	)
	LOCK ALLPAGES
GO

CREATE UNIQUE CLUSTERED INDEX rep_cuadre_pasivas_Key
	ON dbo.rep_cuadre_pasivas (rf_fecha_carga, rf_prod_cobis, rf_cuenta, rf_cliente, rf_operacion) ON 'default'
GO

CREATE NONCLUSTERED INDEX rep_riesgo_liquidez_Key1
	ON dbo.rep_cuadre_pasivas (rf_prod_cobis, rf_cuenta) ON 'default'
GO

