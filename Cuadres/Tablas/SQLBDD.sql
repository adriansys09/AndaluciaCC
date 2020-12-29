/*****************tablas***********************/
if exists (select 1
            from  sysobjects
            where  id = object_id('CC_CUADRE_AHORRO')
            and    type = 'U')
   drop table CC_CUADRE_AHORRO
go

/*==============================================================*/
/* Table: CC_CUADRE_AHORRO                                      */
/*==============================================================*/
create table CC_CUADRE_AHORRO (
   CA_CODIGO            int                            identity,
   CA_NUM_CLIENTE       int                            null,
   CA_CEDULA            varchar(20)                    null,
   CA_CTA_BANCO         varchar(20)                    null,
   CA_NOMBRES           varchar(64)                    null,
   CA_COD_PROD_BANCARIO int                            null,
   CA_FECHAAPERTURAAH   datetime                       null,
   CA_FECHAUTMOV        datetime                       null,
   CA_ESTADO            varchar(30)                    null,
   CA_OFICIAL           varchar(64)                    null,
   CA_OFICINA           varchar(62)                    null,
   CA_DISPONIBLE        money                          null,
   CA_SALDO_DISPONIBLE  money                          null,
   CA_SALDO_CONTABLE    money                          null,
   CA_REMESAS           money                          null,
   CA_VALORENCAJE       money                          null,
   CA_SALDOINTERES      money                          null,
   CA_FECHA_NAC         datetime                       null,
   CA_ESTADOAHPROG      char(1)                        null,
   CA_CONTRATOAHPROG    int                            null,
   CA_DIAPAGAHPROG      tinyint                        null,
   CA_MONTOAHPROG       money                          null,
   CA_DEBITOAHPROG      char(1)                        null,
   CA_CTABANDEBAHPROG   varchar(16)                    null,
   CA_FECHAINIAHPROG    datetime                       null,
   CA_FECHAVENAHPROG    datetime                       null,
   CA_PLAZOAHPROG       smallint                       null,
   CA_MOTIVOAHPROG      varchar(64)                    null,
   CA_NUMCUOTASPAGAHPROG int                            null,
   CA_NUMCUOTASVENAHPROG int                            null,
   CA_FECHA_CORTE       datetime                       null,
   constraint PK_CC_CUADRE_AHORRO primary key (CA_CODIGO)
)
go

if exists (select 1
            from  sysobjects
            where  id = object_id('CC_PLAZO_FIJO_VENCIDOS')
            and    type = 'U')
   drop table CC_PLAZO_FIJO_VENCIDOS
go

/*==============================================================*/
/* Table: CC_PLAZO_FIJO_VENCIDOS                                */
/*==============================================================*/

create table CC_PLAZO_FIJO_VENCIDOS (
   PV_CODIGO            int                            identity,
   PV_OFICINA           smallint                       null,
   PV_NUM_BANCO         varchar(24)                    null,
   PV_ENTE              int                            null,
   PV_DESCRIPCION       varchar(255)                   null,
   PV_OFICIAL           varchar(14)                    null,
   PV_FECHA_VALOR       datetime                       null,
   PV_NUM_DIAS          smallint                       null,
   PV_FECHA_VEN         datetime                       null,
   PV_TASA              float                          null,
   PV_MONTO             money                          null,
   PV_TOTAL_INT_ESTIMADO money                          null,
   PV_TOTAL_INT_ESTIMADO_PFI money                          null,
   PV_TELEFONO          varchar(12)                    null,
   PV_TOTAL_INT_PAGADOS money                          null,
   PV_FECHA_CORTE       datetime                       null,
   constraint PK_CC_PLAZO_FIJO_VENCIDOS primary key (PV_CODIGO)
)
go

if exists (select 1
            from  sysobjects
            where  id = object_id('CC_PLAZO_FIJO_PRAMI')
            and    type = 'U')
   drop table CC_PLAZO_FIJO_PRAMI
go

/*==============================================================*/
/* Table: CC_PLAZO_FIJO_PRAMI                                   */
/*==============================================================*/
create table CC_PLAZO_FIJO_PRAMI (
   PP_CODIGO            int                            identity,
   PP_OFICINA           smallint                       null,
   PP_NUM_BANCO         varchar(24)                    null,
   PP_NOMBRE            varchar(25)                    null,
   PP_FECHA_VALOR       datetime                       null,
   PP_NUM_DIAS          int                            null,
   PP_FECHA_VEN         datetime                       null,
   PP_MONTO_PG_INT      money                          null,
   PP_TASA              float                          null,
   PP_INT               money                          null,
   PP_RETENCION         money                          null,
   PP_DIAS_ACUM         int                            null,
   PP_TOTAL_INT_GANADOS money                          null,
   PP_DIAS_PERI_INT     int                            null,
   PP_TOTAL_INT_PAGADOS money                          null,
   PP_INT_PROVISION     float                          null,
   PP_CREDITO_ATADO     varchar(24)                    null,
   PP_OFICIAL           varchar(14)                    null,
   PP_TIPO_DEPOSITO     varchar(10)                    null,
   PP_ESTADO            varchar(10)                    null,
   PP_MONTO             money                          null,
   PP_COD_CLIENTE       int                            null,
   PP_RETIENE_IMP       char(1)                        null,
   PP_FECHA_CORTE       datetime                       null,
   constraint PK_CC_PLAZO_FIJO_PRAMI primary key (PP_CODIGO)
)
go

if exists (select 1
            from  sysobjects
            where  id = object_id('CC_PLAZO_FIJO_PAGO_INT')
            and    type = 'U')
   drop table CC_PLAZO_FIJO_PAGO_INT
go

/*==============================================================*/
/* Table: CC_PLAZO_FIJO_PAGO_INT                                */
/*==============================================================*/
create table CC_PLAZO_FIJO_PAGO_INT (
   PI_CODIGO            int                            identity,
   PI_FECHA_PAGO        datetime                       null,
   PI_ENTE              int                            null,
   PI_NUM_BANCO         varchar(24)                    null,
   PI_VALOR             money                          null,
   PI_DESCRIPCION       varchar(64)                    null,
   PI_FECHA_EMISION     datetime                       null,
   PI_FECHA_VEN         datetime                       null,
   PI_FPAGO             datetime                       null,
   PI_FECHA_CORTE       datetime                       null,
   constraint PK_CC_PLAZO_FIJO_PAGO_INT primary key (PI_CODIGO)
)
go

if exists (select 1
            from  sysobjects
            where  id = object_id('CC_GARANTIAS')
            and    type = 'U')
   drop table CC_GARANTIAS
go

/*==============================================================*/
/* Table: CC_GARANTIAS                                          */
/*==============================================================*/
create table CC_GARANTIAS (
   GA_CODIGO            int                            identity,
   OFICINA_             smallint                       null,
   GA_CODIGO_EXTERNO    varchar(64)                    null,
   GA_ENTE              int                            null,
   GA_TIPO              varchar(64)                    null,
   GA_PROPIETARIO       varchar(64)                    null,
   GA_ESTADO            varchar(10)                    null,
   GA_VALOR_INICIAL     money                          null,
   GA_VALOR_ACTUAL      money                          null,
   GA_FVIGENCIA_INICIO  datetime                       null,
   GA_FVIGENCIA_FIN     datetime                       null,
   GA_NUM_OPERACION     int                            null,
   GA_BANCO             varchar(24)                    null,
   GA_TOPERACION        varchar(10)                    null,
   GA_FECHA_CORTE       datetime                       null,
   constraint PK_CC_GARANTIAS primary key (GA_CODIGO)
)
go

/***********************sp_rep_pfijo_2105*************************/
if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_liqpfi_2105') and    type = 'U')
   drop table tmp_rep_liqpfi_2105
go

create table tmp_rep_liqpfi_2105
( lp_cliente         int,
  lp_oficina         smallint,
  lp_monto           money,
  lp_tasa            float,
  lp_int_estimado    money,
  lp_fecha_ingreso   datetime,
  lp_fecha_ven       datetime,
  lp_ced_ruc         varchar(13) null,
  lp_nombre          varchar(100),
  lp_operacion       varchar(24),
  lp_subtipo         char(1) null,
  lp_estado          char(4) null,
  lp_fecha_valor     datetime null
)

/**************sp_rep_cuadre_pfijo*********************************************/
if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_liqpfi') and    type = 'U')
   drop table tmp_rep_liqpfi
go
create table tmp_rep_liqpfi
( lp_cliente         int,
  lp_oficina         smallint,
  lp_monto           money,
  lp_tasa            float,
  lp_int_estimado    money,
  lp_fecha_ingreso   datetime,
  lp_fecha_ven       datetime,
  lp_ced_ruc         varchar(13) null,
  lp_nombre          varchar(100),
  lp_operacion       varchar(24),
  lp_subtipo         char(1) null,
  lp_estado          char(4) null,
  lp_fecha_valor     datetime null,
  lp_pignorado		 char(1) null
)
/*****************sp_rep_ahorros_2105*************************/
if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_liqaho1') and    type = 'U')
   drop table tmp_rep_liqaho1
go
create table tmp_rep_liqaho1
( la_cuenta           int,
  la_cliente          int,
  la_nombre           varchar(100),
  la_fecha_aper       datetime,
  la_cta_banco        char(16),
  la_saldo            money    null,
  la_oficina          smallint,
  la_ced_ruc          char(13),
  la_prod_banc        smallint,
  la_subtipo          char(1)
)

if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_credeb_aho_2105') and    type = 'U')
   drop table tmp_rep_credeb_aho_2105
go

create table tmp_rep_credeb_aho_2105
( cd_cta_banco        char(16),
  cd_signo            char(1),
  cd_valor            money,
  cd_numero           int)

  /***************sp_rep_ahorros_210150*********************************************/
if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_liqaho') and    type = 'U')
drop table tmp_rep_liqaho
go

create table tmp_rep_liqaho
( la_cuenta           int,
  la_cliente          int,
  la_nombre           varchar(100),
  la_fecha_aper       datetime,
  la_cta_banco        char(16),
  la_saldo            money    null,
  la_oficina          smallint,
  la_ced_ruc          char(13),
  la_prod_banc        smallint,
  la_subtipo          char(1)
)

if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_credeb') and    type = 'U')
drop table tmp_rep_credeb
go

create table tmp_rep_credeb
( cd_cta_banco        char(16),
  cd_signo            char(1),
  cd_valor            money,
  cd_numero           int)

/****************sp_rep_ahorros_2101**********************************************************************/
if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_liqaho_2101') and    type = 'U')
drop table tmp_rep_liqaho_2101
go

create table tmp_rep_liqaho_2101
( la_cuenta           int,
  la_cliente          int,
  la_nombre           varchar(100),
  la_fecha_aper       datetime,
  la_cta_banco        char(16),
  la_saldo            money    null,
  la_oficina          smallint,
  la_ced_ruc          char(13),
  la_prod_banc        smallint,
  la_subtipo          char(1)
)

if exists (select 1 from  sysobjects where  id = object_id('tmp_rep_credeb_2101') and    type = 'U')
drop table tmp_rep_credeb_2101
go
create table tmp_rep_credeb_2101
( cd_cta_banco        char(16),
  cd_signo            char(1),
  cd_valor            money,
  cd_numero           int
)

