using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Configuration;
using System.Diagnostics;
using System.Data;
using Sybase.Data.AseClient;

namespace ProyectoAndaluciaSvc.DAL
{
    public class dalCargarData
    {
        public int CargarData(DTO.clsCargaDatos ParametrosIngreso, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_cc_carga_datos_diario", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (ParametrosIngreso.Finmes != null)
                            cmd.Parameters.Add(new AseParameter("@i_fin_mes", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Finmes));

                        if (ParametrosIngreso.Fechadesde!= null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_desde", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Fechadesde));
                        if (ParametrosIngreso.FechaHasta != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_hasta", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaHasta));

                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));

                       
                        cmd.ExecuteNonQuery();
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return resultado.Resultado;
        }
        /// <summary>
        /// consulta la fecha de saldo diario y la fecha de cierre 
        /// </summary>
        /// <param name="ParametrosIngreso"></param>
        /// <param name="resultado"></param>
        /// <returns></returns>
        public List<DTO.clsDiasFeriados> CargarDataFechas(DTO.clsFiltro filtro, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();
            List<DTO.clsDiasFeriados> datos = new List<DTO.clsDiasFeriados>();
            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_cc_carga_datos_fechas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        String strTimeoutComando = ConfigurationManager.AppSettings["TimeoutComandos"];
                        if (strTimeoutComando != null && strTimeoutComando.Length > 0)
                            cmd.CommandTimeout = int.Parse(strTimeoutComando);
                        cmd.Parameters.Add(new AseParameter("I_MODO", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Modo));

                        if (filtro.Filtro.Length > 0)
                            cmd.Parameters.Add(new AseParameter("I_FILTRO", AseDbType.VarChar, filtro.Filtro.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Filtro));


                        cmd.Parameters.Add(new AseParameter("@o_fecha_sd", AseDbType.DateTime, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@o_fecha_cierre", AseDbType.DateTime, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));

                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));

                        using (AseDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                DTO.clsDiasFeriados DiasFeriados = new DTO.clsDiasFeriados();
                                DiasFeriados.Codigo = dr["ID_REGISTRO"] as Int32?;
                                DiasFeriados.Ciudad = dr["df_ciudad"] as Int32?;
                                DiasFeriados.Fecha = dr["df_fecha"] as DateTime?;

                                datos.Add(DiasFeriados);
                            }
                        }

                       // cmd.ExecuteNonQuery();

                        resultado.FechaSd= Convert.ToDateTime(cmd.Parameters["@o_fecha_sd"].Value.ToString()==""?null: cmd.Parameters["@o_fecha_sd"].Value.ToString());
                        resultado.FechaCierre = Convert.ToDateTime(cmd.Parameters["@o_fecha_cierre"].Value.ToString()==""?null: cmd.Parameters["@o_fecha_cierre"].Value.ToString());

                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return datos;
        }

        public int CargarData2101(DTO.clsCargaDatos ParametrosIngreso, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_rep_ahorros_2101", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        String strTimeoutComando= ConfigurationManager.AppSettings["TimeoutComandos"];
                        if (strTimeoutComando != null && strTimeoutComando.Length > 0)
                            cmd.CommandTimeout = int.Parse(strTimeoutComando);

                        if (ParametrosIngreso.Finmes != null)
                            cmd.Parameters.Add(new AseParameter("@i_fin_mes", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Finmes));

                        if (ParametrosIngreso.Fechadesde != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_desde", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Fechadesde));
                        if (ParametrosIngreso.FechaHasta != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_hasta", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaHasta));
                        if (ParametrosIngreso.FechaSd != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_sd", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaSd));

                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                        cmd.ExecuteNonQuery();
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return resultado.Resultado;
        }
        public int CargarData210150(DTO.clsCargaDatos ParametrosIngreso, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_rep_ahorros_210150", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        String strTimeoutComando = ConfigurationManager.AppSettings["TimeoutComandos"];
                        if (strTimeoutComando != null && strTimeoutComando.Length > 0)
                            cmd.CommandTimeout = int.Parse(strTimeoutComando);

                        if (ParametrosIngreso.Finmes != null)
                            cmd.Parameters.Add(new AseParameter("@i_fin_mes", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Finmes));

                        if (ParametrosIngreso.Fechadesde != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_desde", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Fechadesde));
                        if (ParametrosIngreso.FechaHasta != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_hasta", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaHasta));
                        if (ParametrosIngreso.FechaSd != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_sd", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaSd));

                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                        cmd.ExecuteNonQuery();
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return resultado.Resultado;
        }
        public int CargarData2105(DTO.clsCargaDatos ParametrosIngreso, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_rep_ahorros_2105", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        String strTimeoutComando = ConfigurationManager.AppSettings["TimeoutComandos"];
                        if (strTimeoutComando != null && strTimeoutComando.Length > 0)
                            cmd.CommandTimeout = int.Parse(strTimeoutComando);

                        if (ParametrosIngreso.Finmes != null)
                            cmd.Parameters.Add(new AseParameter("@i_fin_mes", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Finmes));

                        if (ParametrosIngreso.Fechadesde != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_desde", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Fechadesde));
                        if (ParametrosIngreso.FechaHasta != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_hasta", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaHasta));
                        if (ParametrosIngreso.FechaSd != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_sd", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaSd));
                        if (ParametrosIngreso.Encaje!= null)
                            cmd.Parameters.Add(new AseParameter("@i_encaje", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Encaje));

                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                        cmd.ExecuteNonQuery();
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return resultado.Resultado;
        }
        #region PF
        public int CargarData2103(DTO.clsCargaDatos ParametrosIngreso, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_rep_cuadre_pfijo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        String strTimeoutComando = ConfigurationManager.AppSettings["TimeoutComandos"];
                        if (strTimeoutComando != null && strTimeoutComando.Length > 0)
                            cmd.CommandTimeout = int.Parse(strTimeoutComando);

                        if (ParametrosIngreso.Finmes != null)
                            cmd.Parameters.Add(new AseParameter("@i_fin_mes", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Finmes));

                        if (ParametrosIngreso.Fechadesde != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_desde", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Fechadesde));
                        if (ParametrosIngreso.FechaHasta != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_hasta", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaHasta));
                        if (ParametrosIngreso.FechaSd != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_sd", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaSd));

                        if (ParametrosIngreso.DiasIni!= null)
                            cmd.Parameters.Add(new AseParameter("@i_dias_ini", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.DiasIni));

                        
                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                        cmd.ExecuteNonQuery();
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return resultado.Resultado;
        }
        public int CargarData2105PF(DTO.clsCargaDatos ParametrosIngreso, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..sp_rep_pfijo_2105", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        String strTimeoutComando = ConfigurationManager.AppSettings["TimeoutComandos"];
                        if (strTimeoutComando != null && strTimeoutComando.Length > 0)
                            cmd.CommandTimeout = int.Parse(strTimeoutComando);

                        if (ParametrosIngreso.Finmes != null)
                            cmd.Parameters.Add(new AseParameter("@i_fin_mes", AseDbType.Char, ParametrosIngreso.Finmes.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Finmes));

                        if (ParametrosIngreso.Fechadesde != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_desde", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.Fechadesde));
                        if (ParametrosIngreso.FechaHasta != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_hasta", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaHasta));
                        if (ParametrosIngreso.FechaSd != null)
                            cmd.Parameters.Add(new AseParameter("@i_fecha_sd", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.FechaSd));
                        if (ParametrosIngreso.DiasIni != null)
                            cmd.Parameters.Add(new AseParameter("@i_dias_ini", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, ParametrosIngreso.DiasIni));

                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                        cmd.ExecuteNonQuery();
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CuentaEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = error.Message;
            }
            return resultado.Resultado;
        }
        #endregion

        #region Dias Habiles del sistema
        /// <summary>
        /// Consulta de Aplicacion, puede ser individual (por ID) o con filtros y órdenes.
        /// </summary>
        /// <param name="filtro">El filtro indica el modo, página, condiciones y orden de la consulta. Si viene el ID y modo=0, se consulta el registro específico</param>
        /// <param name="resultado">Contiene el Código, Mensaje y Número de páginas obtenidos como resultados de la consulta</param>
        /// <returns>Retorna la lista , utilizando una lista o arreglo</returns>
        public List<DTO.clsDiasFeriados> DiasHabilesConsultar(DTO.clsFiltro filtro, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["BDD_ANDALUCIA"].ConnectionString;
            List<DTO.clsDiasFeriados> datos = new List<DTO.clsDiasFeriados>();
            resultado = new DTO.clsResultado();

            try
            {
                using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Aplicacion_QRY", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (filtro.Id != null || filtro.Id > 0)
                            cmd.Parameters.Add(new AseParameter("I_ID", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Id));

                        cmd.Parameters.Add(new AseParameter("I_MODO", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Modo));
                        cmd.Parameters.Add(new AseParameter("I_FILAS", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Filas));

                        if (filtro.Filtro.Length > 0)
                            cmd.Parameters.Add(new AseParameter("I_FILTRO", AseDbType.VarChar, filtro.Filtro.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Filtro));
                        if (filtro.Orden.Length > 0)
                            cmd.Parameters.Add(new AseParameter("I_ORDEN", AseDbType.VarChar, filtro.Orden.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Orden));

                        cmd.Parameters.Add(new AseParameter("I_IR_A_PAGINA", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, filtro.Pagina));

                        cmd.Parameters.Add(new AseParameter("@O_ROWS", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_PAGES", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                        using (AseDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                DTO.clsDiasFeriados DiasFeriados = new DTO.clsDiasFeriados();
                               DiasFeriados.Codigo = dr["ID_REGISTRO"] as Int32?;
                               DiasFeriados.Ciudad = dr["df_ciudad"] as Int32?;
                               DiasFeriados.Fecha= dr["df_fecha"] as DateTime?;
                               

                                datos.Add(DiasFeriados);
                            }
                        }
                        resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                        resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();
                        resultado.TotalPaginas = (cmd.Parameters["@o_fecha_sd"].Value != DBNull.Value) ? Convert.ToInt32(cmd.Parameters["@O_PAGES"].Value) : 0;
                        resultado.TotalRegistros = (cmd.Parameters["@O_ROWS"].Value != DBNull.Value) ? Convert.ToInt32(cmd.Parameters["@O_ROWS"].Value) : 0;

                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL AplicacionConsultar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return datos;
        }
        #endregion
    }
}