
use anda_reporte
go

drop proc sp_rep_pfijo_2105
go

create proc sp_rep_pfijo_2105(
       @s_date                datetime    =  null,
       @s_user                varchar(14) = 'isb_batch',
       @s_term                varchar(64) = 'isb_batch',
       @i_fecha_hasta         datetime,
       @i_dias_ini            tinyint     = 1,
	   @O_RETVAL		INT OUTPUT,
	   @O_RETMSG		VARCHAR(3000) OUTPUT

)  

as

declare @w_sp_name            varchar(32),
        @w_error              int,
        @w_msj_error          varchar(255),
        -- VARIABLES CUENTA
        @w_monto              money,
        @w_operacion          varchar(24),
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
        @w_fecha_valor        datetime,
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
        @w_estado             catalogo,
        -- VARIABLES DE TRABAJO
        @w_num_reg            int,
        @w_contador           int,
        @w_cont_aux           int,
        @w_fecha_ini          datetime,
        @w_prod_cobis         tinyint,
        @w_subtipo            char(1)  

 set @O_RETVAL=0
 set @O_RETMSG=''
-- TABLAS TEMPORALES
--create table tmp_rep_liqpfi_2105
--( lp_cliente         int,
--  lp_oficina         smallint,
--  lp_monto           money,
--  lp_tasa            float,
--  lp_int_estimado    money,
--  lp_fecha_ingreso   datetime,
--  lp_fecha_ven       datetime,
--  lp_ced_ruc         varchar(13) null,
--  lp_nombre          varchar(100),
--  lp_operacion       varchar(24),
--  lp_subtipo         char(1) null,
--  lp_estado          char(4) null,
--  lp_fecha_valor     datetime null
--)
truncate table tmp_rep_liqpfi_2105

--INICIALIZO VARIABLES
select @w_sp_name        = 'sp_rep_pfijo_2105',
       @w_cuenta         = '2103',
       @w_tasa_base      = '0',
       @w_activo_pasivo  = 'PASIVO',
       @w_moneda         = 'USD',
       @w_calificacion   = '',         -- VACIO PARA AHORROS Y PLAZO FIJO, 
       @w_valor_comision = 0,          -- la Coop. no cobra comisiones futuras
       @w_base_periodo   = 360,        -- 360 para cartera y pfijo 365 para ahorros 0 certificados
       @w_clase_oper     = '0',        -- 1 para todas la CARTERA Coop no reestrura operaciones 0 para ahorros y pfijo
       @w_frecuencia     = '0',        -- para todos los casos
       @w_tdiv_revision  =  0,         -- para cartera es la tasa actual menos la tasa ajustada la Coop no sabe a que tasa se cobrara
       @w_entidad        = 'ANDALUCIA',
       @w_tipo_vcto      = 1,          -- 0 PARA CARTERA Y AHORROS 1 PARA PFIJO
       @w_sensible       = 'S',        -- S PARA CARTERA X VENCER  AHORRO Y PFIJO -N- PARA CARTERA NODEVENGA VENCIDA Y CERTIFICADOS
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
       @w_prod_cobis     = 14          -- PLAZO FIJO

select @w_prod_cobis = @w_prod_cobis * 10 + @i_dias_ini
       	
-- CONTROL DE TIEMPO DE EJECUCION
insert into rep_riesgo_reloj values (107,getdate())

--FECHA DEL SISTEMA
if @s_date is null
   select @s_date = fp_fecha
   from   cobis..ba_fecha_proceso

-- CODIGO ENTIDAD
select @w_cod_entidad = convert(int,pa_char)
from   cobis..cl_parametro
where  pa_nemonico = 'CSIB'
and    pa_producto = 'ADM'

-- FECHA DE INICIO PARA OBTENER LA CUENTA
select @w_fecha_ini = dateadd(dd,@i_dias_ini,@i_fecha_hasta)

-- ERROR EN CASO DE EXISTIR DATOS EN LA TABLA
if exists (select 1 from anda_reporte..rep_cuadre_pasivas
           where  rf_prod_cobis = @w_prod_cobis and rf_fecha_carga=@i_fecha_hasta and rf_cuenta like '2105%')
begin
   select @w_error = 700002
   print 'YA EXISTEN DATOS DE AHORROS EN LA TABLA DE RIESGO DE LIQUIDEZ'
   set @O_RETVAL=@w_error
   set @O_RETMSG='YA EXISTEN DATOS DE AHORROS EN LA TABLA DE RIESGO DE LIQUIDEZ'
   return @O_RETVAL
   --goto ERROR1
end

-- CARGA INICIAL DE OPERACIONES
insert into tmp_rep_liqpfi_2105
      (lp_cliente,      lp_oficina,       lp_monto,
       lp_tasa,         lp_int_estimado,  lp_fecha_ingreso,
       lp_fecha_ven,    lp_ced_ruc,       lp_nombre,
       lp_operacion,    lp_subtipo,       lp_estado,
       lp_fecha_valor)
select op_ente,         op_oficina,       op_monto,
       op_tasa,         op_total_int_estimado,op_fecha_ingreso,
       op_fecha_ven,    en_ced_ruc,       op_descripcion,
       op_num_banco,    en_subtipo,       op_estado,
       op_fecha_valor
from   cob_pfijo..pf_operacion,
       cobis..cl_ente
where  op_operacion >= 1
and    op_estado in ('ACT','VEN','XACT')   ---MRI 06mar2014  
and    en_ente = op_ente

select @w_num_reg = @@rowcount


-- CONTROL DE TIEMPO DE EJECUCION
insert into rep_riesgo_reloj values (108,getdate())


if @w_num_reg > 0
   print ' REGISTROS A PROCESAR PLAZO FIJO %1!',@w_num_reg
else
begin
   select @w_error = 708153
   print 'NO EXISTEN OPERACIONES DE PLAZO FIJO PARA CONSULTAR'
	set @O_RETVAL=@w_error
	set @O_RETMSG='NO EXISTEN OPERACIONES DE PLAZO FIJO PARA CONSULTAR'
	return @O_RETVAL
   --goto ERROR1
end

-- SELECCION DE OPERACIONES 

declare cursor_rep_pfi1 cursor for
select lp_cliente,      lp_oficina,       lp_monto,
       lp_tasa,         lp_int_estimado,  lp_fecha_ingreso,
       lp_fecha_ven,    lp_ced_ruc,       lp_nombre,
       lp_operacion,    lp_subtipo,       lp_estado,
       lp_fecha_valor
from   tmp_rep_liqpfi_2105
open cursor_rep_pfi1
fetch cursor_rep_pfi1 into  
       @w_cliente,       @w_oficina,         @w_monto,
       @w_tasa_interes,  @w_valor_interes,   @w_fecha_emision,
       @w_fecha_vcto,    @w_identificacion,  @w_nombre,
       @w_operacion,     @w_subtipo,         @w_estado,
       @w_fecha_valor 

while @@sqlstatus !=2  
begin   

   if @@sqlstatus = 1 begin
      select @w_error = 710004
	  set @O_RETVAL=@w_error
	set @O_RETMSG='Error en la lectura del cursor'
	return @O_RETVAL
      --goto ERROR1
   end

   select @w_contador  = @w_contador + 1,
          @w_cont_aux  = @w_cont_aux + 1,
          @w_msj_error = null

   if @w_cont_aux = 1000
   begin 
      Print ' Numreg %1!   PFIJO:%2!', @w_contador, @w_operacion
      select @w_cont_aux = 0 
   end

   -- INICIALIZA VARIABLES
   select @w_cuota_capital  = isnull(@w_monto,0),
          @w_valor_interes  = isnull(@w_valor_interes,0),
          @w_cuota_total    = isnull(@w_monto,0)

   -- FECHA DE REPRECIO
   select @w_fecha_reprecio = isnull(@w_fecha_vcto,@i_fecha_hasta)

   if @i_fecha_hasta > @w_fecha_reprecio 
      select @w_fecha_reprecio = @i_fecha_hasta

   -- Descripcion OFICINA
   select @w_oficina_nom = of_nombre
   from   cobis..cl_oficina
   where  of_oficina = @w_oficina

   select @w_producto = 'PADPF'

   if exists ( select 1 from 	cob_custodia..cu_custodia C,cob_custodia..cu_cliente_garantia,cob_custodia..cu_tipo_custodia,
								cob_credito..cr_gar_propuesta, cob_cartera..ca_operacion
				where op_tramite             = gp_tramite
				and cu_codigo_externo      = gp_garantia
				and cu_codigo_externo      = cg_codigo_externo
				and cu_tipo                = tc_tipo
				and cu_filial              = 1
				and cg_principal           = 'S'
				and cu_tipo              = 'GARPFI'
				and op_estado not in     (0,99,3,6)
				and cu_plazo_fijo = @w_operacion)
begin
   -- CUENTA CONTABLE  MRI se incluye la fecha ini, 10JUL2013 cambio @w_fecha_ini por  @i_fecha_hasta
  -- operaciones XACT  va a la cta 210330  MRI 06mar2014
   if @w_estado = 'XACT'
     select @w_cuenta   = '210530',
            @w_producto = 'PABTB',
            @w_fecha_vcto = @w_fecha_valor
  else
   if @w_fecha_vcto <= @i_fecha_hasta
     select @w_cuenta   = '210140',
            @w_producto = 'PAVISTA'
   else
   if @w_fecha_vcto between @w_fecha_ini and dateadd(dd,30,@w_fecha_ini)
     select @w_cuenta = '210505',
     		@w_producto = 'PABTB'
   else
   if @w_fecha_vcto between dateadd(dd,31,@w_fecha_ini) and dateadd(dd,31+59,@w_fecha_ini)
     select @w_cuenta = '210510',
     		@w_producto = 'PABTB'
   else
   if @w_fecha_vcto between dateadd(dd,31+60,@w_fecha_ini) and dateadd(dd,31+60+89,@w_fecha_ini)
     select @w_cuenta = '210515',
            @w_producto = 'PABTB'
   else
   if @w_fecha_vcto between dateadd(dd,31+60+90,@w_fecha_ini) and dateadd(dd,31+60+90+179,@w_fecha_ini)
     select @w_cuenta = '210520',
     @w_producto = 'PABTB'
   else
   if @w_fecha_vcto > dateadd(dd,31+60+90+180,@w_fecha_ini) 
     select @w_cuenta = '210525',
     @w_producto = 'PABTB'
   else
     select @w_cuenta = '210525',
     		@w_producto = 'PABTB'
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
              @w_dias_reprecio,  @w_dias_vcto,     @w_operacion,       @w_cod_entidad,
              @w_oficina,        @w_nombre,        @w_dividendo,       @w_tipo_cca,
              @w_tipo_persona,   @w_tipo_empresa,  @w_debito,          @w_credito,
              @w_tipo_cliente,   @w_prod_cobis)

print 'inserto'

      if @@error <> 0 begin
         select @w_msj_error = 'ERROR EN INSERCION DE CUENTAS DE DPF'
         goto ERROR
      end
	end -- cierra el if de validaci+Ýn BTB
   COMMIT TRAN

   goto SIGUIENTE

   ERROR:
      exec cob_cartera..sp_errorlog 
           @i_fecha       = @s_date,                      
           @i_error       = @w_error,
           @i_usuario     = @s_user, 
           @i_tran        = 7999,
           @i_tran_name   = @w_sp_name,
           @i_cuenta      = @w_operacion,
           @i_descripcion = @w_msj_error,
           @i_rollback    = 'S'
         
      while @@trancount > 0 
            rollback tran
      goto SIGUIENTE
      

   SIGUIENTE:
   fetch cursor_rep_pfi1 into
         @w_cliente,       @w_oficina,         @w_monto,
         @w_tasa_interes,  @w_valor_interes,   @w_fecha_emision,
         @w_fecha_vcto,    @w_identificacion,  @w_nombre,
         @w_operacion,     @w_subtipo,         @w_estado,
         @w_fecha_valor
end

close cursor_rep_pfi1
deallocate cursor cursor_rep_pfi1

if @w_cont_aux > 0
begin 
   Print ' Numreg %1!   PFIJO:%2!', @w_contador, @w_operacion
end

-- CONTROL DE TIEMPO DE EJECUCION
insert into rep_riesgo_reloj values (109,getdate())

return 0

--ERROR1:
--   exec cobis..sp_cerror
--   @t_debug = 'N',
--   @t_file  = '',  
--   @t_from  = @w_sp_name,
--   @i_num   = @w_error,
--   @i_sev   = 1

--   return 1                                                                                                                                                                                                            
                                                                                                                                                                                         
