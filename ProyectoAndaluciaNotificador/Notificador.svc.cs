using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using System.IO;
using System.Configuration;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Diagnostics;


namespace ProyectoAndaluciaNotificador
{
    public class Notificador : INotificador
    {
        /// <summary>
        /// Metodo para el envio de correo de una aplicacion hacia uno o varios Correos.
        /// </summary>
        /// <param name="datosCorreo">Configuracion Guardada Tabla de correoAplicacion</param>
        /// <param name="asunto">Asunto del correo electronico</param>
        /// <param name="parametros">Conjunto de parámetros para personalizar la plantilla html en formato Clave, Valor. Las claves van a ser reemplazadas en la plantilla con los campos $$ o con {{}} </param>
        /// <param name="anexos">Archivos anexos a ser incluidos</param>
        /// <returns>resultado que retorna Result=0 Exitoso; Result!=0 Error Mensaje="Descripcion del Error"</returns>
        public DTO.clsResultado EnviarCorreo(DTO.clsCorreoAplicacion datosCorreo, string asunto, Dictionary<string, string> parametros, List<string> anexos)
        {
            
            DTO.clsFiltro filtro = new DTO.clsFiltro();
            DTO.clsResultado resultado = new DTO.clsResultado();
            DAL.dalCorreoAplicacion dal = new DAL.dalCorreoAplicacion();
            List<DTO.clsCorreoAplicacion> listaCorreos = new List<DTO.clsCorreoAplicacion>();
            filtro.Modo = 1;
            filtro.Pagina = 1;
            filtro.Filas = 9999;
            filtro.Filtro = "AP_ESTADO ='V' AND CA_CODIGO_APLICACION ='"+datosCorreo.CodigoAplicacion+"'";
            filtro.Orden = "";
            

            listaCorreos = dal.CorreoAplicacionConsultar(filtro, out resultado);
            if (resultado.Resultado != 0)
            {
                resultado.Resultado = -11;
                resultado.Mensaje = resultado.Mensaje;
                return resultado;
            }//no existe aplicacion

            for (int i = 0; i < listaCorreos.Count; i++)
            {
                //validaciones
                if (listaCorreos[i].Destino.Length <= 0)
                {
                    resultado.Resultado=-1;
                    resultado.Mensaje = "No tiene Correo de Destino";
                    break;
                }// No tiene Correo de Destino
                if (asunto.Length <= 0)
                {
                    resultado.Resultado=-2;
                    resultado.Mensaje = "El correo no tiene asunto";
                    break;
                } // No tiene asunto
                if (listaCorreos[i].PlantillaHtml.Length <= 0)
                {
                    resultado.Resultado=-3; // No ha indicado el archivo de plantilla con el contenido del mensaje
                    resultado.Mensaje = "No ha indicado el archivo de plantilla con el contenido del mensaje";
                    break;
                }
                // Cargar los parámetros del web.config
                string strNombreLog = ConfigurationManager.AppSettings["nombreLog"];
                string strDirectorioHtmls = ConfigurationManager.AppSettings["directorioHtmls"];

                // Validar que exista el archivo de plantilla del contenido del email
                string filePath = Path.Combine(HttpRuntime.AppDomainAppPath, strDirectorioHtmls + listaCorreos[i].PlantillaHtml);
                if (!File.Exists(filePath)) {
                    resultado.Resultado=-4;
                    resultado.Mensaje = "Archivo de plantilla de contenido no existe";
                    break;
                }      // Archivo de plantilla de contenido no existe
                       // Validar que los anexos existan
                if (anexos != null)
                {
                    for (int j = 0; j < anexos.Count; j++)
                    {
                        if (!File.Exists(anexos[j]))
                        {
                            resultado.Mensaje = "Anexo no existente";
                            resultado.Resultado=- 5;
                            break;
                        }    // Anexo no existente
                    }
                }

                //Creamos un nuevo Objeto de mensaje
                System.Net.Mail.MailMessage mmsg = new System.Net.Mail.MailMessage();

                //Direccion de correo electronico a la que queremos enviar el mensaje
                mmsg.To.Add(listaCorreos[i].Destino);

                //Nota: La propiedad To es una colección que permite enviar el mensaje a más de un destinatario

                //Asunto
                mmsg.Subject = asunto;
                mmsg.SubjectEncoding = System.Text.Encoding.UTF8;

                //Direccion de correo electronico que queremos que reciba una copia del mensaje
                //if (strEmailCopia.Length > 0)
                //    mmsg.Bcc.Add(strEmailCopia); // Opcional envía una copia del mail a esta dirección

                if (anexos != null)
                    for (int k = 0; k < anexos.Count; k++)
                        mmsg.Attachments.Add(new Attachment(anexos[k]));

                //Cuerpo del Mensaje
                string readFile = "";
                FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read);

                using (StreamReader reader = new StreamReader(stream))
                {
                    readFile = reader.ReadToEnd();
                }

                string myString = "";
                myString = readFile;
                if (parametros != null)
                {
                    for (int l = 0; l < parametros.Count; l++)
                    {
                        myString = myString.Replace("$$" + parametros.Keys.ElementAt(l), parametros.Values.ElementAt(l));
                        myString = myString.Replace("{{" + parametros.Keys.ElementAt(l) + "}}", parametros.Values.ElementAt(l));
                    }
                }

                AlternateView htmlView = AlternateView.CreateAlternateViewFromString(myString, Encoding.UTF8, MediaTypeNames.Text.Html);

                if (listaCorreos[i].Logotipo.Length > 0)
                {
                    string imageLogo = Path.Combine(Path.Combine(HttpRuntime.AppDomainAppPath, "./img"), listaCorreos[i].Logotipo);
                    LinkedResource logo = new LinkedResource(imageLogo);
                    logo.ContentId = "logo";
                    htmlView.LinkedResources.Add(logo);
                }

                if (listaCorreos[i].Firma.Length > 0)
                {
                    string imageFirma = Path.Combine(Path.Combine(HttpRuntime.AppDomainAppPath, "./img"), listaCorreos[i].Firma);
                    LinkedResource firma = new LinkedResource(imageFirma);
                    firma.ContentId = "firma";
                    htmlView.LinkedResources.Add(firma);
                }

                mmsg.BodyEncoding = System.Text.Encoding.UTF8;
                mmsg.AlternateViews.Add(htmlView);

                //Correo electronico desde la que enviamos el mensaje
                mmsg.From = new System.Net.Mail.MailAddress(listaCorreos[i].UserOrigen);

                /*-------------------------CLIENTE DE CORREO----------------------*/

                //Creamos un objeto de cliente de correo
                System.Net.Mail.SmtpClient cliente = new System.Net.Mail.SmtpClient();

                //Hay que crear las credenciales del correo emisor
                cliente.UseDefaultCredentials = false;
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
                if (listaCorreos[i].SmtpServerSsl.Equals("S"))
                    cliente.EnableSsl = true;
                else
                    cliente.EnableSsl = false;

                cliente.Credentials = new System.Net.NetworkCredential(listaCorreos[i].UserOrigen, listaCorreos[i].ClaveOrigen);

                //Lo siguiente es obligatorio si enviamos el mensaje desde Gmail  OJO PENDIENTE

                cliente.Host = listaCorreos[i].SmtpServer; //Para Gmail "smtp.gmail.com";
                cliente.Port = int.Parse(listaCorreos[i].SmtpServerPort.ToString());

                /*-------------------------ENVIO DE CORREO----------------------*/
                try
                {
                    //Enviamos el mensaje      
                    cliente.Send(mmsg);
                }
                catch (System.Net.Mail.SmtpException ex)
                {
                    string strSource = ConfigurationManager.AppSettings["NombreLog"];
                    using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                    {
                        eventLog.WriteEntry("Error en Servicio Correo ... " + " Descripción=  " + ex.Message, EventLogEntryType.Error, 1100);
                        eventLog.MachineName = "EnviarInvitacion";
                    }
                    resultado.Resultado= - 10;
                    resultado.Mensaje = "Error en Servicio Correo ... " + " Descripción=  " + ex.Message;

                }
                finally
                {
                    mmsg.Dispose();
                }
            }
            return resultado;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="correosDesstino">Lista de destinos (correos a quien debe llegar)</param>
        /// <param name="datosCorreo">Se debe enviar datosCorreo.CodigoAplicacion(código de Aplicación).</param>
        /// <param name="asunto">Asunto del correo electrónico</param>
        /// <param name="parametros">Parámetros para personalizar la plantilla html en formato Clave, Valor. Las claves van a ser reemplazadas en la plantilla con los campos $$ o con {{}}</param>
        /// <param name="anexos">Archivos anexos a ser incluidos</param>
        /// <returns>retorna 0 si fue exitoso, -1; No tiene Correo de Destino; -2 No tiene asunto; 
        /// -3 No ha indicado el archivo de plantilla con el contenido del mensaje;
        /// -4 Archivo de plantilla de contenido no existe; -5 Anexo no existente;
        /// -10 Error no controlado..... se guada en el event viewer
        /// </returns>
        public int EnviarCorreoVarios(List<string> correosDesstino, DTO.clsCorreoAplicacion datosCorreo, string asunto, Dictionary<string, string> parametros, List<string> anexos)
        {
            DTO.clsFiltro filtro = new DTO.clsFiltro();
            DTO.clsResultado resultado = new DTO.clsResultado();
            DAL.dalCorreoAplicacion dal = new DAL.dalCorreoAplicacion();
            List<DTO.clsCorreoAplicacion> listaCorreos = new List<DTO.clsCorreoAplicacion>();
            filtro.Modo = 1;
            filtro.Pagina = 1;
            filtro.Filas = 9999;
            filtro.Filtro = "AP_ESTADO ='V' AND CA_CODIGO_APLICACION ='" + datosCorreo.CodigoAplicacion + "'";
            filtro.Orden = "";

            listaCorreos = dal.CorreoAplicacionConsultar(filtro, out resultado);
            var config = listaCorreos[0];
            for (int i = 0; i < correosDesstino.Count; i++)
            {
                //validaciones
                if (correosDesstino[i].Length <= 0) return -1; // No tiene Correo de Destino
                if (asunto.Length <= 0) return -2; // No tiene asunto
                if (config.PlantillaHtml.Length <= 0) return -3; // No ha indicado el archivo de plantilla con el contenido del mensaje

                // Cargar los parámetros del web.config
                string strNombreLog = ConfigurationManager.AppSettings["nombreLog"];
                string strDirectorioHtmls = ConfigurationManager.AppSettings["directorioHtmls"];

                // Validar que exista el archivo de plantilla del contenido del email
                string filePath = Path.Combine(HttpRuntime.AppDomainAppPath, strDirectorioHtmls + config.PlantillaHtml);
                if (!File.Exists(filePath)) return -4;      // Archivo de plantilla de contenido no existe
                                                            // Validar que los anexos existan
                if (anexos != null)
                    for (int j = 0; j < anexos.Count; j++)
                        if (!File.Exists(anexos[j])) return -5;    // Anexo no existente

                //Creamos un nuevo Objeto de mensaje
                System.Net.Mail.MailMessage mmsg = new System.Net.Mail.MailMessage();

                //Direccion de correo electronico a la que queremos enviar el mensaje
                mmsg.To.Add(correosDesstino[i]);

                //Nota: La propiedad To es una colección que permite enviar el mensaje a más de un destinatario

                //Asunto
                mmsg.Subject = asunto;
                mmsg.SubjectEncoding = System.Text.Encoding.UTF8;

                //Direccion de correo electronico que queremos que reciba una copia del mensaje
                //if (strEmailCopia.Length > 0)
                //    mmsg.Bcc.Add(strEmailCopia); // Opcional envía una copia del mail a esta dirección

                if (anexos != null)
                    for (int k = 0; k < anexos.Count; k++)
                        mmsg.Attachments.Add(new Attachment(anexos[k]));

                //Cuerpo del Mensaje
                string readFile = "";
                FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read);

                using (StreamReader reader = new StreamReader(stream))
                {
                    readFile = reader.ReadToEnd();
                }

                string myString = "";
                myString = readFile;
                if (parametros != null)
                {
                    for (int l = 0; l < parametros.Count; l++)
                    {
                        myString = myString.Replace("$$" + parametros.Keys.ElementAt(l), parametros.Values.ElementAt(l));
                        myString = myString.Replace("{{" + parametros.Keys.ElementAt(l) + "}}", parametros.Values.ElementAt(l));
                    }
                }

                AlternateView htmlView = AlternateView.CreateAlternateViewFromString(myString, Encoding.UTF8, MediaTypeNames.Text.Html);

                if (config.Logotipo.Length > 0)
                {
                    string imageLogo = Path.Combine(Path.Combine(HttpRuntime.AppDomainAppPath, "./img"), config.Logotipo);
                    LinkedResource logo = new LinkedResource(imageLogo);
                    logo.ContentId = "logo";
                    htmlView.LinkedResources.Add(logo);
                }

                if (config.Firma.Length > 0)
                {
                    string imageFirma = Path.Combine(Path.Combine(HttpRuntime.AppDomainAppPath, "./img"), config.Firma);
                    LinkedResource firma = new LinkedResource(imageFirma);
                    firma.ContentId = "firma";
                    htmlView.LinkedResources.Add(firma);
                }

                mmsg.BodyEncoding = System.Text.Encoding.UTF8;
                mmsg.AlternateViews.Add(htmlView);

                //Correo electronico desde la que enviamos el mensaje
                mmsg.From = new System.Net.Mail.MailAddress(config.UserOrigen);

                /*-------------------------CLIENTE DE CORREO----------------------*/

                //Creamos un objeto de cliente de correo
                System.Net.Mail.SmtpClient cliente = new System.Net.Mail.SmtpClient();

                //Hay que crear las credenciales del correo emisor
                cliente.UseDefaultCredentials = false;
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
                if (config.SmtpServerSsl.Equals("S"))
                    cliente.EnableSsl = true;
                else
                    cliente.EnableSsl = false;

                cliente.Credentials = new System.Net.NetworkCredential(config.UserOrigen, config.ClaveOrigen);

                //Lo siguiente es obligatorio si enviamos el mensaje desde Gmail  OJO PENDIENTE
                
                cliente.Host = config.SmtpServer; //Para Gmail "smtp.gmail.com";
                cliente.Port = int.Parse(config.SmtpServerPort.ToString());

                /*-------------------------ENVIO DE CORREO----------------------*/
                try
                {

                    //Enviamos el mensaje      

                    cliente.Send(mmsg);


                }
                catch (System.Net.Mail.SmtpException ex)
                {
                    string strSource = ConfigurationManager.AppSettings["NombreLog"];
                    using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                    {
                        eventLog.WriteEntry("Error en Servicio Correo ... " + " Descripción=  " + ex.Message, EventLogEntryType.Error, 1100);
                        eventLog.MachineName = "EnviarInvitacion";
                    }
                    return -10;

                }
                finally
                {
                    mmsg.Dispose();
                }
            }
            return 0;
        }

    }
}
