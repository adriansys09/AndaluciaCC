use anda_reporte
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

