use anda_reporte
go

drop proc sp_rep_ahorros_2105
go


create proc sp_rep_ahorros_2105(
       @s_date                datetime    =  null,
       @s_user                varchar(14) = 'isb_batch',
       @s_term                varchar(64) = 'isb_batch',
       @i_fin_mes             char(1)     = 'S',
       @i_fecha_desde         datetime,       -- Fecha desde para consulta de Creditos y Debitos
       @i_fecha_hasta         datetime,
       @i_fecha_sd	      datetime,
       @i_encaje	      char(1),                                   
	      @O_RETVAL		INT OUTPUT,
	   @O_RETMSG		VARCHAR(3000) OUTPUT
)  
as
declare @w_sp_name            varchar(32),
        @w_error              int,
        @w_msj_error          varchar(255),
        -- VARIABLES CUENTA
        @w_ah_cuenta            int,
        @w_cta_banco          char(16),
        @w_saldo              money,
        @w_prod_banc          smallint,
        @w_subtipo            char(1),
        -- VARIABLES LIQUIDEZ
        @w_cuenta             varchar(13),
        @w_producto           varchar(20),
        @w_tasa_base          varchar(13),
        @w_identificacion     varchar(13),
        @w_cliente            int,
        @w_activo_pasivo      varchar(13),
        @w_calificacion       varchar(1),
        @w_moneda             varchar(3),
        @w_fecha_emision      datetime,
        @w_fecha_reprecio     datetime,
        @w_fecha_vcto         datetime,
        @w_cuota_capital      money,
        @w_valor_interes      money,
        @w_valor_comision     money,
        @w_cuota_total        money,
        @w_tasa_interes       money,
        @w_base_periodo       int,
        @w_clase_oper         varchar(15),
        @w_frecuencia         varchar(60),
        @w_tdiv_revision      money,
        @w_entidad            varchar(30),
        @w_oficina_nom        varchar(30),
        @w_tipo_vcto          int,
        @w_sensible           varchar(1),
        @w_desglosado         int,
        @w_tasa_fija_var      varchar(50),
        @w_numero_cuotas      int,
        @w_dias_reprecio      int,
        @w_dias_vcto          int,
        @w_cod_entidad        int,
        @w_oficina            int,
        @w_nombre             varchar(100),
        @w_dividendo          smallint,
        @w_tipo_cca           varchar(10),
        @w_tipo_persona       varchar(3),
        @w_tipo_empresa       varchar(3),
        @w_debito             money,
        @w_credito            money,
        @w_tipo_cliente       int,
        -- VARIABLES DE TRABAJO
        @w_moneda_loc         tinyint,
        @w_num_reg            int,
        @w_contador           int,
        @w_cont_aux           int,
        @w_substr1            char(3), 
        @w_substr2            char(1),
        @w_saldo_ah           money,
        @w_prod_cobis         tinyint,
        @w_fecha_saldohis     datetime,
        @w_acepta_prod	      char(1) ,
	@w_bloqueo_encaje 	money      
 
 set @O_RETVAL=0
 set @O_RETMSG=''
-- TABLAS TEMPORALES
--create table tmp_rep_liqaho1
--( la_cuenta           int,
--  la_cliente          int,
--  la_nombre           varchar(100),
--  la_fecha_aper       datetime,
--  la_cta_banco        char(16),
--  la_saldo            money    null,
--  la_oficina          smallint,
--  la_ced_ruc          char(13),
--  la_prod_banc        smallint,
--  la_subtipo          char(1)
--)

--create table tmp_rep_credeb_aho_2105
--( cd_cta_banco        char(16),
--  cd_signo            char(1),
--  cd_valor            money,
--  cd_numero           int)
truncate table tmp_rep_liqaho1
truncate table tmp_rep_credeb_aho_2105
--INICIALIZO VARIABLES
select @w_sp_name        = 'sp_rep_ahorros_2105',
       @w_tasa_base      = '0',
       @w_activo_pasivo  = 'PASIVO',
       @w_moneda         = 'USD',
       @w_fecha_reprecio = @i_fecha_hasta,
       @w_fecha_vcto     = @i_fecha_hasta, 
       @w_calificacion   = '',         -- VACIO PARA AHORROS Y PLAZO FIJO, 
       @w_valor_interes  = 0,          -- PARA AHORROS Y PLAZO FIJO  
       @w_valor_comision = 0,          -- la Coop. no cobra comisiones futuras
       @w_base_periodo   = 365,        -- 360 para cartera y pfijo 365 para ahorros 0 certificados
       @w_clase_oper     = '0',        -- 1 para todas la CARTERA Coop no reestrura operaciones 0 para ahorros y pfijo
       @w_frecuencia     = '0',        -- para todos los casos
       @w_tdiv_revision  =  0,         -- para cartera es la tasa actual menos la tasa ajustada la Coop no sabe a que tasa se cobrara
       @w_entidad        = 'ANDALUCIA',
       @w_tipo_vcto      = 0,          -- 0 PARA CARTERA Y AHORROS 1 PARA PFIJO
       @w_desglosado     = 0,          -- 0 PARA TODOS LOS CASOS
       @w_tasa_fija_var  = '0',        -- 0 PARA TASA INT FIJA 1 VARIABLE
       @w_numero_cuotas  = 0,          -- PARA AHORROS PFIJO Y CERTIF 0
       @w_dias_reprecio  = 0, 
       @w_dias_vcto      = 0,
       @w_dividendo      = 1,
       @w_tipo_cca       = '', 
       @w_tipo_persona   = 'NAT',
       @w_tipo_empresa   = 'N',
       @w_debito         = 0,
       @w_credito        = 0,
       @w_tipo_cliente   = 1,
       @w_contador       = 0,
       @w_cont_aux       = 0,
       @w_prod_cobis     = 4           -- AHORROS 

-- CONTROL DE TIEMPO DE EJECUCION
insert into rep_riesgo_reloj values (101,getdate())

--FECHA DEL SISTEMA
if @s_date is null
   select @s_date = fp_fecha
   from   cobis..ba_fecha_proceso

-- CODIGO ENTIDAD
select @w_cod_entidad = convert(int,pa_char)
from   cobis..cl_parametro
where  pa_nemonico = 'CSIB'
and    pa_producto = 'ADM'

-- CODIGO MONEDA LOCAL
select @w_moneda_loc = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'MLO'
and    pa_producto = 'ADM'

-- VERIFICA FECHA DESDE Y HASTA
if @i_fin_mes = 'S'
begin

   if datepart(mm,@i_fecha_hasta) = datepart(mm,dateadd(dd,1,@i_fecha_hasta))
   begin
      select @w_error = 700000
      print 'FECHA HASTA NO CORRESPONDE AL FIN DE MES'
	  set @O_RETVAL=@w_error
	  set @O_RETMSG='FECHA HASTA NO CORRESPONDE AL FIN DE MES'
	  
	  return @O_RETVAL
      --goto ERROR1
   end
   select @i_fecha_desde = dateadd(dd,-1*datepart(dd,@i_fecha_hasta)+1,@i_fecha_hasta)
end
else
begin
   if datediff(dd, @i_fecha_desde, @i_fecha_hasta) < 0
   begin
      select @w_error = 700001
      print 'EL RANGO DE FECHAS PARA CONSULTA DE CREDITOS Y DEBITOS, ES INCORRECTO'
	  set @O_RETVAL=@w_error
	  set @O_RETMSG='FECHA HASTA NO CORRESPONDE AL FIN DE MES'
	  
	  return @O_RETVAL
      --goto ERROR1
   end
end

-- ERROR EN CASO DE EXISTIR DATOS EN LA TABLA
if exists (select 1 from anda_reporte..rep_cuadre_pasivas
           where  rf_prod_cobis = @w_prod_cobis and rf_fecha_carga=@i_fecha_desde and rf_cuenta like '2105%')
begin
   select @w_error = 700002
   print 'YA EXISTEN DATOS DE AHORROS EN LA TABLA DE RIESGO DE LIQUIDEZ'
   set @O_RETVAL=@w_error
   set @O_RETMSG='YA EXISTEN DATOS DE AHORROS EN LA TABLA DE RIESGO DE LIQUIDEZ'
   return @O_RETVAL
   --goto ERROR1
end


-- FECHA PARA CONSULTA DE SALDOS HISTORICOS  MRI_anda 04MAR13, 10JUL2013

select @w_fecha_saldohis = @s_date
print ' Fecha de Consulta de Saldos Historicos... %1! ', @w_fecha_saldohis


-- CARGA INICIAL DE CUENTAS DE AHORROS
insert into tmp_rep_liqaho1
      (la_cuenta,      la_cliente,     la_nombre,
       la_fecha_aper,  la_cta_banco,   la_saldo,
       la_oficina,     la_ced_ruc,     la_prod_banc,
       la_subtipo
      )
select ah_cuenta,      ah_cliente,     ah_nombre,
       ah_fecha_aper,  ah_cta_banco,   ROUND(ah_disponible + ah_12h + ah_24h + ah_48h + ah_remesas,2),
       ah_oficina,     ah_ced_ruc,     ah_prod_banc,
       en_subtipo
from   cob_ahorros..ah_cuenta,       cobis..cl_ente
where  ah_filial  = 1
and    ah_moneda  = @w_moneda_loc
and    ah_estado <> "C"
and    ROUND(ah_disponible + ah_12h + ah_24h + ah_48h + ah_remesas,2) > 0
and    en_ente    = ah_cliente
and    ah_bloqueo_encaje > 0

select @w_num_reg = @@rowcount

if @w_num_reg > 0
   print ' REGISTROS A PROCESAR AHORROS %1!',@w_num_reg
else
begin
   select @w_error = 708153
   print 'NO EXISTEN CUENTAS DE AHORROS PARA CONSULTAR'
   set @O_RETVAL=@w_error
	  set @O_RETMSG='NO EXISTEN CUENTAS DE AHORROS PARA CONSULTAR'
	  
	  return @O_RETVAL
   --goto ERROR1
end


-- CONTROL DE TIEMPO DE EJECUCION
insert into rep_riesgo_reloj values (102,getdate())



-- SELECCION DE OPERACIONES 
declare cursor_ahorros_2105 cursor for
select la_cuenta,      la_cliente,     la_nombre,
       la_fecha_aper,  la_cta_banco,   la_saldo,
       la_oficina,     la_ced_ruc,     la_prod_banc,
       la_subtipo
from   tmp_rep_liqaho1

open cursor_ahorros_2105

fetch cursor_ahorros_2105 into  
       @w_ah_cuenta,       @w_cliente,     @w_nombre,
       @w_fecha_emision,   @w_cta_banco,   @w_saldo,
       @w_oficina,        @w_identificacion,  @w_prod_banc,
       @w_subtipo
      
while @@sqlstatus !=2  
begin   

   if @@sqlstatus = 1 begin
      select @w_error = 710004
      --goto ERROR1
	  set @O_RETVAL=@w_error
	  set @O_RETMSG='Error en la lectura del cursor'
	  
	  return @O_RETVAL

   end

   select @w_contador  = @w_contador + 1,
          @w_cont_aux  = @w_cont_aux + 1,
          @w_msj_error = null,
          @w_saldo_ah  = 0,
          @w_credito   = 0,
          @w_debito    = 0


   if @w_cont_aux = 1000
   begin 
      Print ' Numreg %1!   CTA_AHO:%2!', @w_contador, @w_cta_banco
      select @w_cont_aux = 0 
   end
   select @w_bloqueo_encaje = 0
   -- SALDO DIARIO
   select @w_saldo_ah = sd_saldo_contable
   from   cob_ahorros_his..ah_saldo_diario
   where  sd_cuenta = @w_ah_cuenta
   and    sd_fecha  =@i_fecha_sd


	select	@w_bloqueo_encaje = isnull(ah_bloqueo_encaje , 0)
	from cob_ahorros..ah_cuenta
	where ah_cuenta = @w_ah_cuenta

   select @w_saldo_ah = @w_bloqueo_encaje 

   select @w_saldo_ah = isnull(@w_saldo_ah,@w_saldo)


   -- CARGA INICIAL DE MOVIMIENTOS
   truncate table tmp_rep_credeb_aho_2105

   insert into tmp_rep_credeb_aho_2105
         (cd_cta_banco,  cd_signo,  cd_valor,       cd_numero)
   select hm_cta_banco,  hm_signo,  sum(hm_valor),  count(hm_signo)
   from   cob_ahorros_his..ah_his_movimiento
   where  hm_cta_banco  = @w_cta_banco
   and    hm_fecha     >= @i_fecha_desde
   and    hm_fecha     <= @i_fecha_hasta
   group  by hm_cta_banco,  hm_signo


   -- MOVIMIENTOS
   select @w_credito = isnull(cd_valor,0)
   from   tmp_rep_credeb_aho_2105
   where  cd_cta_banco = @w_cta_banco
   and    cd_signo     = 'C'

   select @w_debito  = isnull(cd_valor,0)
   from   tmp_rep_credeb_aho_2105
   where  cd_cta_banco = @w_cta_banco
   and    cd_signo     = 'D'

   select @w_credito = isnull(@w_credito,0),
          @w_debito  = isnull(@w_debito,0)
            
   -- INICIALIZA VARIABLES
   select @w_cuota_capital = isnull(@w_saldo_ah,0),
          @w_cuota_total   = isnull(@w_saldo_ah,0),
          @w_oficina_nom   = null,
          @w_cuenta        = null,
          @w_substr1       = null,
          @w_substr2       = null,
          @w_producto      = 'PRODUCTO AHORROS'
       
   -- Descripcion OFICINA
   select @w_oficina_nom = of_nombre
   from   cobis..cl_oficina
   where  of_oficina = @w_oficina

   -- SENSIBLE	    
   select @w_tasa_interes = 0.00,
          @w_sensible     = 'N',
          @w_acepta_prod  = 'N' 

   --- 08/27/2015	MRI-anda  incluye todos los productos bancarios tipo A y que se encuentren Vigente

   select @w_acepta_prod = 'S'
   from cob_remesas..pe_pro_bancario
   where pb_pro_bancario = @w_prod_banc
   and   pb_estado = 'V'
   and   pb_tipo_pro_bancario = 'A'



  --- if @w_prod_banc in (1,2,3,6,7,8) 
   if @w_acepta_prod = 'S'
      
      select @w_cuenta       = '210505',
             @w_producto     = 'PADPF',
             @w_tasa_interes = 2.00,
             @w_sensible     = 'S'
   else


   -- TIPO PERSONA O EMPRESA
   if @w_subtipo = 'C'
      select @w_tipo_persona = 'JUR',
             @w_tipo_empresa = 'PRI',
             @w_tipo_cliente = 5
   else
      select @w_tipo_persona = 'NAT',
             @w_tipo_empresa = 'N',
             @w_tipo_cliente = 1




   BEGIN TRAN

      insert into rep_cuadre_pasivas
             (rf_fecha_carga,    rf_cuenta,        rf_producto,        rf_tasa_base,
              rf_identificacion, rf_cliente,       rf_activo_pasivo,   rf_calificacion,
              rf_moneda,         rf_fecha_emision, rf_fecha_reprecio,  rf_fecha_vcto,
              rf_cuota_capital,  rf_valor_interes, rf_valor_comision,  rf_cuota_total,
              rf_tasa_interes,   rf_base_periodo,  rf_clase_oper,      rf_frecuencia,
              rf_tdiv_revision,  rf_entidad,       rf_oficina,         rf_tipo_vcto,
              rf_sensible,       rf_desglosado,    rf_tasa_fija_var,   rf_numero_cuotas,
              rf_dias_reprecio,  rf_dias_vcto,     rf_operacion,       rf_cod_entidad,
              rf_cod_oficina,    rf_nombre,        rf_dividendo,       rf_tipo_cca,
              rf_tipo_persona,   rf_tipo_empresa,  rf_debito,          rf_credito,
              rf_tipo_cliente,   rf_prod_cobis)
      values (@i_fecha_hasta,    @w_cuenta,        @w_producto,        @w_tasa_base,
              @w_identificacion, @w_cliente,       @w_activo_pasivo,   @w_calificacion,
              @w_moneda,         @w_fecha_emision, @w_fecha_reprecio,  @w_fecha_vcto,
              @w_cuota_capital,  @w_valor_interes, @w_valor_comision,  @w_cuota_total,
              @w_tasa_interes,   @w_base_periodo,  @w_clase_oper,      @w_frecuencia,
              @w_tdiv_revision,  @w_entidad,       @w_oficina_nom,     @w_tipo_vcto,
              @w_sensible,       @w_desglosado,    @w_tasa_fija_var,   @w_numero_cuotas,
              @w_dias_reprecio,  @w_dias_vcto,     @w_cta_banco,       @w_cod_entidad,
              @w_oficina,        @w_nombre,        @w_dividendo,       @w_tipo_cca,
              @w_tipo_persona,   @w_tipo_empresa,  @w_debito,          @w_credito,
              @w_tipo_cliente,   @w_prod_cobis)
         
      if @@error <> 0 begin
         select @w_msj_error = 'ERROR EN INSERCION DE CUENTAS DE AHORROS'
         --goto ERROR
		 set @O_RETVAL=7999
	  set @O_RETMSG=@w_msj_error
	  return @O_RETVAL
      end

   COMMIT TRAN

   goto SIGUIENTE

   ERROR:
      exec cob_cartera..sp_errorlog 
           @i_fecha       = @s_date,                      
           @i_error       = @w_error,
           @i_usuario     = @s_user, 
           @i_tran        = 7999,
           @i_tran_name   = @w_sp_name,
           @i_cuenta      = @w_cta_banco,
           @i_descripcion = @w_msj_error,
           @i_rollback    = 'S'
         
      while @@trancount > 0 
            rollback tran
      goto SIGUIENTE
      

   SIGUIENTE:
   fetch cursor_ahorros_2105 into
         @w_ah_cuenta,      @w_cliente,         @w_nombre,
         @w_fecha_emision,  @w_cta_banco,       @w_saldo,
         @w_oficina,        @w_identificacion,  @w_prod_banc,
         @w_subtipo
end

close cursor_ahorros_2105
deallocate cursor cursor_ahorros_2105

if @w_cont_aux > 0
begin 
    Print ' Numreg %1!   CTA_AHO:%2!', @w_contador, @w_cta_banco
end

-- CONTROL DE TIEMPO DE EJECUCION
insert into rep_riesgo_reloj values (103,getdate())

return 0

ERROR1:
   exec cobis..sp_cerror
   @t_debug = 'N',
   @t_file  = '',  
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_sev   = 1

   return 1

                                                                                                                                     
