-- genera la cuenta 210135 -- netamente ahorros, aqui no estan sumando los valores de cheques


exec sp_rep_ahorros_2101 
       @s_user                = 'isb_batch',
       @s_term                = 'isb_batch',
       @i_fin_mes             = 'S',-- DEBE IR DESDE INICIO DE MES HASTA FIN DE MES
       @i_fecha_desde         = '08/01/2020', --FECHA DE ANDA_BI..ANDA_FECHA_COB 
       @i_fecha_hasta         = '08/31/2020', 
       @i_fecha_sd	      = '08/31/2020',  ---MAXIMA FECHA DE LA TABLA COBAHORROS HIS "AH_SALDO_DIARIO"
	   @O_RETMSG		= NULL,
	   @O_RETVAL		= NULL


-- genera cuenta 2101t50 -- netamente ahorros y son los valores de cheques

exec sp_rep_ahorros_210150  
       @s_user                = 'isb_batch',
       @s_term                = 'isb_batch',
       @i_fin_mes             = 'S',
       @i_fecha_desde         = '08/01/2020',
       @i_fecha_hasta         = '08/31/2020',
       @i_fecha_sd	      = '08/31/2020',
	   @O_RETMSG		= NULL,
	   @O_RETVAL		= NULL

-- genera la 2105 cuando en las cuentas de ahorros se generan bloqueos por encaje (OJO ESTA CUENTA TAMBIEN ES AFECTADA POR DPF)

exec sp_rep_ahorros_2105   
       @s_user                = 'isb_batch',
       @s_term                = 'isb_batch',
       @i_fin_mes             = 'S',
       @i_fecha_desde         = '08/01/2020',
       @i_fecha_hasta         = '08/31/2020',--ULTIMO DIA DE MES
       @i_fecha_sd	      = '08/31/2020',--ESTE SE TOMA EL ULTIMO DIA HABIL
       @i_encaje	      = 'S',
	   @O_RETMSG		= NULL,
	   @O_RETVAL		= NULL

-- genera las cuentas contables 2103 (con sus bandas) y las cuenta 210140 (plazos vencidos), netamente solo plazos fijos

exec sp_rep_cuadre_pfijo   
       @s_user                = 'isb_batch',
       @s_term                = 'isb_batch',
       @i_fecha_hasta         = '08/31/2020',--FECHA DE ANDA_BI..ANDA_FECHA_COB 
       @i_dias_ini            = 0,
	   @O_RETMSG		= NULL,
	   @O_RETVAL		= NULL

-- genera 2105, de los plazo fijos que esta  como garant¡as de un cr‚dito.

exec sp_rep_pfijo_2105     
       @s_user                = 'isb_batch', 
       @s_term                = 'isb_batch',
       @i_fecha_hasta         = '08/31/2020',--FECHA DE ANDA_BI..ANDA_FECHA_COB ES PARA LA FECHA HASTA
       @i_dias_ini            = 0,
	   @O_RETMSG		= NULL,
	   @O_RETVAL		= NULL

