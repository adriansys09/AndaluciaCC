using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Configuration;
using System.Diagnostics;
using System.Data;
using System.Data.SqlClient;
using Sybase.Data.AseClient;

namespace ProyectoAndaluciaNotificador.DAL
{
    /// <summary>
    /// Resumen de funcionalidad
    /// </summary>
    public class dalCorreoAplicacion
    {

        #region APLICACION
        /// <summary>
        /// Resumen de funcionalidad
        /// </summary>
        /// <param name="Aplicacion">El nuevo requerimiento a ser creado</param>
        /// <param name="resultado">Los datos del resultado obtenidos después de su inserción</param>
        /// <returns>El resultado de la operación, contiene el código de error generado por la operación de base de datos. Si retorna 0 es OK</returns>
        public DTO.clsAplicacion AplicacionCrear(DTO.clsAplicacion Aplicacion, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            string strMsg = "OK";
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Aplicacion_ADD", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (Aplicacion.Codigo != null)
                            cmd.Parameters.Add(new AseParameter("@I_Codigo", AseDbType.VarChar, Aplicacion.Codigo.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Codigo));

                        if (Aplicacion.Nombre != null)
                            cmd.Parameters.Add(new AseParameter("@I_Nombre", AseDbType.VarChar, Aplicacion.Nombre.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Nombre));

                        if (Aplicacion.Descripcion != null)
                            cmd.Parameters.Add(new AseParameter("@I_Descripcion", AseDbType.VarChar, Aplicacion.Descripcion.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Descripcion));

                        if (Aplicacion.Estado != null)
                            cmd.Parameters.Add(new AseParameter("@I_Estado", AseDbType.Char, Aplicacion.Estado.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Estado));


                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));

                        
                        
                            using (AseDataReader dr = cmd.ExecuteReader())
                            {
                                if (dr.Read())
                                {
                                    Aplicacion.Codigo = dr["AP_CODIGO"] as String;
                                    Aplicacion.Nombre = dr["AP_NOMBRE"] as String;
                                    Aplicacion.Descripcion = dr["AP_DESCRIPCION"] as String;
                                    Aplicacion.Estado = dr["AP_ESTADO"] as String;

                                }
                            }
                            resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                            resultado.Mensaje = strMsg = cmd.Parameters["@O_RETMSG"].Value.ToString();
                        
                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL AplicacionCrear... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 16);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return Aplicacion;
        }

        /// <summary>
        /// Consulta de Aplicacion, puede ser individual (por ID) o con filtros y órdenes.
        /// </summary>
        /// <param name="filtro">El filtro indica el modo, página, condiciones y orden de la consulta. Si viene el ID y modo=0, se consulta el registro específico</param>
        /// <param name="resultado">Contiene el Código, Mensaje y Número de páginas obtenidos como resultados de la consulta</param>
        /// <returns>Retorna la lista , utilizando una lista o arreglo</returns>
        public List<DTO.clsAplicacion> AplicacionConsultar(DTO.clsFiltro filtro, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            List<DTO.clsAplicacion> datos = new List<DTO.clsAplicacion>();
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
                                    DTO.clsAplicacion Aplicacion = new DTO.clsAplicacion();
                                    Aplicacion.Codigo = dr["AP_CODIGO"] as String;
                                    Aplicacion.Nombre = dr["AP_NOMBRE"] as String;
                                    Aplicacion.Descripcion = dr["AP_DESCRIPCION"] as String;
                                    Aplicacion.Estado = dr["AP_ESTADO"] as String;

                                    datos.Add(Aplicacion);
                                }
                            }
                            resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                            resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();
                            resultado.TotalPaginas = (cmd.Parameters["@O_PAGES"].Value != DBNull.Value) ? Convert.ToInt32(cmd.Parameters["@O_PAGES"].Value) : 0;
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

        /// <summary>
        /// Actualización de Aplicacion por ID
        /// </summary>
        /// <param name="Aplicacion">Aplicacion que se desea actualizar</param>
        /// <param name="resultado">Obtiene el código y el mensaje de resultado</param>
        /// <returns>Retorna el código de error de la transacción. Si retorna 0 es OK</returns>
        public DTO.clsAplicacion AplicacionActualizar(DTO.clsAplicacion Aplicacion, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Aplicacion_UPD", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (Aplicacion.Codigo != null)
                            cmd.Parameters.Add(new AseParameter("@I_Codigo", AseDbType.VarChar, Aplicacion.Codigo.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Codigo));

                        if (Aplicacion.Nombre != null)
                            cmd.Parameters.Add(new AseParameter("@I_Nombre", AseDbType.VarChar, Aplicacion.Nombre.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Nombre));

                        if (Aplicacion.Descripcion != null)
                            cmd.Parameters.Add(new AseParameter("@I_Descripcion", AseDbType.VarChar, Aplicacion.Descripcion.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Descripcion));

                        if (Aplicacion.Estado != null)
                            cmd.Parameters.Add(new AseParameter("@I_Estado", AseDbType.Char, Aplicacion.Estado.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Estado));


                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));

                        
                            using (AseDataReader dr = cmd.ExecuteReader())
                            {
                                if (dr.Read())
                                {
                                    Aplicacion.Codigo = dr["AP_CODIGO"] as String;
                                    Aplicacion.Nombre = dr["AP_NOMBRE"] as String;
                                    Aplicacion.Descripcion = dr["AP_DESCRIPCION"] as String;
                                    Aplicacion.Estado = dr["AP_ESTADO"] as String;

                                }
                            }
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
                    eventLog.WriteEntry("Error en DAL AplicacionActualizar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return Aplicacion;
        }

        /// <summary>
        /// Eliminación de Aplicacion por ID
        /// </summary>
        /// <param name="Aplicacion">Información de Aplicacion a ser eliminado</param>
        /// <param name="resultado">Obtiene el código y el mensaje de resultado</param>
        /// <returns>Retorna el código de error de la transacción. Si retorna 0 es OK</returns>
        public int AplicacionEliminar(DTO.clsAplicacion Aplicacion, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Aplicacion_DEL", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (Aplicacion.Codigo != null)
                            cmd.Parameters.Add(new AseParameter("@I_Codigo", AseDbType.VarChar, Aplicacion.Codigo.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Codigo));

                        cmd.Parameters.Add(new AseParameter("@I_Version", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, Aplicacion.Version));

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
                    eventLog.WriteEntry("Error en DAL AplicacionEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return resultado.Resultado;
        }

        #endregion

        #region CORREO_CONFIGURACION
        /// <summary>
        /// Resumen de funcionalidad
        /// </summary>
        /// <param name="CorreoAplicacion">El nuevo requerimiento a ser creado</param>
        /// <param name="resultado">Los datos del resultado obtenidos después de su inserción</param>
        /// <returns>El resultado de la operación, contiene el código de error generado por la operación de base de datos. Si retorna 0 es OK</returns>
        public DTO.clsCorreoAplicacion CorreoAplicacionCrear(DTO.clsCorreoAplicacion CorreoAplicacion, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            string strMsg = "OK";
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Correo_Aplicacion_ADD", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (CorreoAplicacion.Codigo != null)
                            cmd.Parameters.Add(new AseParameter("@I_Codigo", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.Codigo));

                        if (CorreoAplicacion.CodigoAplicacion != null)
                            cmd.Parameters.Add(new AseParameter("@I_CodigoAplicacion", AseDbType.VarChar, CorreoAplicacion.CodigoAplicacion.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.CodigoAplicacion));

                        if (CorreoAplicacion.UserOrigen != null)
                            cmd.Parameters.Add(new AseParameter("@I_UserOrigen", AseDbType.VarChar, CorreoAplicacion.UserOrigen.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.UserOrigen));

                        if (CorreoAplicacion.ClaveOrigen != null)
                            cmd.Parameters.Add(new AseParameter("@I_ClaveOrigen", AseDbType.VarChar, CorreoAplicacion.ClaveOrigen.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.ClaveOrigen));

                        if (CorreoAplicacion.SmtpServer != null)
                            cmd.Parameters.Add(new AseParameter("@I_SmtpServer", AseDbType.VarChar, CorreoAplicacion.SmtpServer.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.SmtpServer));

                        if (CorreoAplicacion.SmtpServerPort != null)
                            cmd.Parameters.Add(new AseParameter("@I_SmtpServerPort", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.SmtpServerPort));

                        if (CorreoAplicacion.SmtpServerSsl != null)
                            cmd.Parameters.Add(new AseParameter("@I_SmtpServerSsl", AseDbType.Char, CorreoAplicacion.SmtpServerSsl.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.SmtpServerSsl));


                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));


                            using (AseDataReader dr = cmd.ExecuteReader())
                            {
                                if (dr.Read())
                                {
                                    CorreoAplicacion.Codigo = dr["CA_CODIGO"] as Int32?;
                                    CorreoAplicacion.CodigoAplicacion = dr["CA_CODIGO_APLICACION"] as String;
                                    CorreoAplicacion.UserOrigen = dr["CA_USER_ORIGEN"] as String;
                                    CorreoAplicacion.ClaveOrigen = dr["CA_CLAVE_ORIGEN"] as String;
                                    CorreoAplicacion.SmtpServer = dr["CA_SMTP_SERVER"] as String;
                                    CorreoAplicacion.SmtpServerPort = dr["CA_SMTP_SERVER_PORT"] as Int32?;
                                    CorreoAplicacion.SmtpServerSsl = dr["CA_SMTP_SERVER_SSL"] as String;

                                }
                            }
                            resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                            resultado.Mensaje = strMsg = cmd.Parameters["@O_RETMSG"].Value.ToString();
                      
                    }
                    con.Close();
                }
            }
            catch (Exception error)
            {
                string strSource = ConfigurationManager.AppSettings["NombreLog"];
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("Error en DAL CorreoAplicacionCrear... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 16);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return CorreoAplicacion;
        }

        /// <summary>
        /// Consulta de CorreoAplicacion, puede ser individual (por ID) o con filtros y órdenes.
        /// </summary>
        /// <param name="filtro">El filtro indica el modo, página, condiciones y orden de la consulta. Si viene el ID y modo=0, se consulta el registro específico</param>
        /// <param name="resultado">Contiene el Código, Mensaje y Número de páginas obtenidos como resultados de la consulta</param>
        /// <returns>Retorna la lista , utilizando una lista o arreglo</returns>
        public List<DTO.clsCorreoAplicacion> CorreoAplicacionConsultar(DTO.clsFiltro filtro, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            List<DTO.clsCorreoAplicacion> datos = new List<DTO.clsCorreoAplicacion>();
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("anda_reporte..CORREOAPLICACION_QRY", con))
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
                                    DTO.clsCorreoAplicacion CorreoAplicacion = new DTO.clsCorreoAplicacion();
                                    CorreoAplicacion.Codigo = dr["CA_CODIGO"] as Int32?;
                                    CorreoAplicacion.CodigoAplicacion = dr["CA_CODIGO_APLICACION"] as String;
                                    CorreoAplicacion.UserOrigen = dr["CA_USER_ORIGEN"] as String;
                                    CorreoAplicacion.ClaveOrigen = dr["CA_CLAVE_ORIGEN"] as String;
                                    CorreoAplicacion.SmtpServer = dr["CA_SMTP_SERVER"] as String;
                                    CorreoAplicacion.SmtpServerPort = dr["CA_SMTP_SERVER_PORT"] as Int32?;
                                    CorreoAplicacion.SmtpServerSsl = dr["CA_SMTP_SERVER_SSL"] as String;
                                   
                                    CorreoAplicacion.PlantillaHtml = dr["CA_PLANTILLAHTML"] as String;
                                    CorreoAplicacion.Logotipo = dr["CA_LOGOTIPO"] as String;
                                    CorreoAplicacion.Firma = dr["CA_FIRMA"] as String;
                                    CorreoAplicacion.Destino= dr["CA_DESTINO"] as String;
                                    datos.Add(CorreoAplicacion);
                                }
                            }
                            resultado.Resultado = Convert.ToInt32(cmd.Parameters["@O_RETVAL"].Value);
                            resultado.Mensaje = cmd.Parameters["@O_RETMSG"].Value.ToString();
                            resultado.TotalPaginas = (cmd.Parameters["@O_PAGES"].Value != DBNull.Value) ? Convert.ToInt32(cmd.Parameters["@O_PAGES"].Value) : 0;
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
                    eventLog.WriteEntry("Error en DAL CorreoAplicacionConsultar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return datos;
        }

        /// <summary>
        /// Actualización de CorreoAplicacion por ID
        /// </summary>
        /// <param name="CorreoAplicacion">CorreoAplicacion que se desea actualizar</param>
        /// <param name="resultado">Obtiene el código y el mensaje de resultado</param>
        /// <returns>Retorna el código de error de la transacción. Si retorna 0 es OK</returns>
        public DTO.clsCorreoAplicacion CorreoAplicacionActualizar(DTO.clsCorreoAplicacion CorreoAplicacion, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Correo_Aplicacion_UPD", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (CorreoAplicacion.Codigo != null)
                            cmd.Parameters.Add(new AseParameter("@I_Codigo", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.Codigo));

                        if (CorreoAplicacion.CodigoAplicacion != null)
                            cmd.Parameters.Add(new AseParameter("@I_CodigoAplicacion", AseDbType.VarChar, CorreoAplicacion.CodigoAplicacion.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.CodigoAplicacion));

                        if (CorreoAplicacion.UserOrigen != null)
                            cmd.Parameters.Add(new AseParameter("@I_UserOrigen", AseDbType.VarChar, CorreoAplicacion.UserOrigen.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.UserOrigen));

                        if (CorreoAplicacion.ClaveOrigen != null)
                            cmd.Parameters.Add(new AseParameter("@I_ClaveOrigen", AseDbType.VarChar, CorreoAplicacion.ClaveOrigen.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.ClaveOrigen));

                        if (CorreoAplicacion.SmtpServer != null)
                            cmd.Parameters.Add(new AseParameter("@I_SmtpServer", AseDbType.VarChar, CorreoAplicacion.SmtpServer.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.SmtpServer));

                        if (CorreoAplicacion.SmtpServerPort != null)
                            cmd.Parameters.Add(new AseParameter("@I_SmtpServerPort", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.SmtpServerPort));

                        if (CorreoAplicacion.SmtpServerSsl != null)
                            cmd.Parameters.Add(new AseParameter("@I_SmtpServerSsl", AseDbType.Char, CorreoAplicacion.SmtpServerSsl.Length, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.SmtpServerSsl));


                        cmd.Parameters.Add(new AseParameter("@O_RETVAL", AseDbType.Integer, 0, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, 0));
                        cmd.Parameters.Add(new AseParameter("@O_RETMSG", AseDbType.NVarChar, 128, ParameterDirection.Output, false, 0, 0, "", DataRowVersion.Default, ""));

        
                            using (AseDataReader dr = cmd.ExecuteReader())
                            {
                                if (dr.Read())
                                {
                                    CorreoAplicacion.Codigo = dr["CA_CODIGO"] as Int32?;
                                    CorreoAplicacion.CodigoAplicacion = dr["CA_CODIGO_APLICACION"] as String;
                                    CorreoAplicacion.UserOrigen = dr["CA_USER_ORIGEN"] as String;
                                    CorreoAplicacion.ClaveOrigen = dr["CA_CLAVE_ORIGEN"] as String;
                                    CorreoAplicacion.SmtpServer = dr["CA_SMTP_SERVER"] as String;
                                    CorreoAplicacion.SmtpServerPort = dr["CA_SMTP_SERVER_PORT"] as Int32?;
                                    CorreoAplicacion.SmtpServerSsl = dr["CA_SMTP_SERVER_SSL"] as String;

                                }
                            }
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
                    eventLog.WriteEntry("Error en DAL CorreoAplicacionActualizar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return CorreoAplicacion;
        }

        /// <summary>
        /// Eliminación de CorreoAplicacion por ID
        /// </summary>
        /// <param name="CorreoAplicacion">Información de CorreoAplicacion a ser eliminado</param>
        /// <param name="resultado">Obtiene el código y el mensaje de resultado</param>
        /// <returns>Retorna el código de error de la transacción. Si retorna 0 es OK</returns>
        public int CorreoAplicacionEliminar(DTO.clsCorreoAplicacion CorreoAplicacion, out DTO.clsResultado resultado)
        {
            string strConexion = ConfigurationManager.ConnectionStrings["CADENA"].ConnectionString;
            resultado = new DTO.clsResultado();

            try
            {
                 using (AseConnection con = new AseConnection(strConexion))
                {
                    con.Open();
                    using (AseCommand cmd = new AseCommand("Correo_Aplicacion_DEL", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (CorreoAplicacion.Codigo != null)
                            cmd.Parameters.Add(new AseParameter("@I_Codigo", AseDbType.Integer, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.Codigo));


                        cmd.Parameters.Add(new AseParameter("@I_Version", AseDbType.DateTime, -1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, CorreoAplicacion.Version));

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
                    eventLog.WriteEntry("Error en DAL CorreoAplicacionEliminar... " + " Descripción=  " + error.Message + " Stack: " + error.StackTrace, EventLogEntryType.Error, 0);
                }
                resultado.Resultado = -10;
                resultado.Mensaje = ConfigurationManager.AppSettings["ErrorInternoMensaje"];
            }
            return resultado.Resultado;
        }

        #endregion

    }
}