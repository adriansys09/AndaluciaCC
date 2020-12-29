
/***********************************************************************************************
	Archivo         :	sp_cc_carga_datos_diario.sql								
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

if exists (select * from sysobjects where name = 'sp_cc_carga_datos_diario')
	drop proc sp_cc_carga_datos_diario
go

CREATE PROCEDURE sp_cc_carga_datos_diario
(	
 @i_fin_mes        CHAR(1),
 @i_producto	   varchar(10) =NULL,
 --@i_fecha_desde    DATETIME=null,
 --@i_fecha_hasta    DATETIME=null, 
 
 @O_RETVAL		INT OUTPUT,
 @O_RETMSG		VARCHAR(3000) OUTPUT
 
)
AS
BEGIN
DECLARE @W_FECHA_SD DATETIME,
@W_FECHA_HASTA DATETIME,
@W_FECHA_DESDE DATETIME

	-- FECHA SALDO DIARIO
	SELECT @W_FECHA_SD=MAX(sd_fecha) 
	from cob_ahorros_his..ah_saldo_diario 
	--fecha de anda_bi..anda_fecha_cob
	select  @W_FECHA_DESDE =afc_fecha_cierre from anda_bi..anda_fecha_cob

	SELECT @W_FECHA_SD,@W_FECHA_DESDE

	if @i_producto='2101'
	begin 
			exec @O_RETVAL=sp_rep_ahorros_2101 
			@s_user                = 'isb_batch',
			@s_term                = 'isb_batch',
			@i_fin_mes             = @i_fin_mes,--'S',-- DEBE IR DESDE INICIO DE MES HASTA FIN DE MES
			@i_fecha_desde         = @i_fecha_desde,--'08/01/2020', 
			@i_fecha_hasta         = @i_fecha_hasta,--'08/31/2020', 
			@i_fecha_sd	      =		@W_FECHA_SD--'08/31/2020'  ---MAXIMA FECHA DE LA TABLA COBAHORROS HIS "AH_SALDO_DIARIO"
	   
		if @O_RETVAL=700002
		begin 
			set @O_RETMSG ='YA EXISTEN DATOS DE AHORROS EN LA TABLA DE RIESGO DE LIQUIDEZ'
		end 
	end 
-- genera cuenta 2101t50 -- netamente ahorros y son los valores de cheques
	if @i_producto='210150'
	begin 
		exec @O_RETVAL=sp_rep_ahorros_210150  
		   @s_user                = 'isb_batch',
		   @s_term                = 'isb_batch',
		   @i_fin_mes             = 'S',
		   @i_fecha_desde         = @i_fecha_desde,--'08/01/2020',
		   @i_fecha_hasta         = @i_fecha_hasta,--'08/31/2020',
		   @i_fecha_sd	      = @W_FECHA_SD--'08/31/2020'

	 end 
---- genera la 2105 cuando en las cuentas de ahorros se generan bloqueos por encaje (OJO ESTA CUENTA TAMBIEN ES AFECTADA POR DPF)
	if @i_producto='2105'
	begin 
		exec sp_rep_ahorros_2105   
		   @s_user                = 'isb_batch',
		   @s_term                = 'isb_batch',
		   @i_fin_mes             = 'S',
		   @i_fecha_desde         = @i_fecha_desde,--'08/01/2020',
		   @i_fecha_hasta         = @i_fecha_hasta,--ULTIMO DIA DE MES
		   @i_fecha_sd	      = @W_FECHA_SD,--'08/31/2020',--ESTE SE TOMA EL ULTIMO DIA HABIL
		   @i_encaje	      = 'S'

	   end 
-- genera las cuentas contables 2103 (con sus bandas) y las cuenta 210140 (plazos vencidos), netamente solo plazos fijos
	if @i_producto='2103'
		begin 
	exec sp_rep_cuadre_pfijo   
		   @s_user                = 'isb_batch',
		   @s_term                = 'isb_batch',
		   @i_fecha_hasta         = @W_FECHA_HASTA_PF,--'08/31/2020',--FECHA DE ANDA_BI..ANDA_FECHA_COB 
		   @i_dias_ini            = 0
	end
-- genera 2105, de los plazo fijos que esta  como garant¡as de un cr‚dito.
	if @i_producto='2103'
	begin 
	exec sp_rep_pfijo_2105     
       @s_user                = 'isb_batch', 
       @s_term                = 'isb_batch',
       @i_fecha_hasta         = @W_FECHA_HASTA_PF,--'08/31/2020',--FECHA DE ANDA_BI..ANDA_FECHA_COB ES PARA LA FECHA HASTA
       @i_dias_ini            = 0
	end
END

