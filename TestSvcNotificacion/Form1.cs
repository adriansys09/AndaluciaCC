using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Cryptography.X509Certificates;

namespace TestSvcNotificacion
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnEnviarCorreo_Click(object sender, EventArgs e)
        {
            //if (ConfigurationManager.AppSettings["CertificadoSeguridad"] == null || ConfigurationManager.AppSettings["CertificadoSeguridad"].Length == 0)
            //{ // Cuando no hay certificado de seguridad se utiliza http y hay que usar basicHttpBinding en el web.config
            //    System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, certificate, chain, sslPolicyErrors) => true);
            //}

            notificador.clsCorreoAplicacion correo = new notificador.clsCorreoAplicacion();

            notificador.NotificadorClient svc = new notificador.NotificadorClient();

            try
            {
                // Si hay certificado de seguridad se utiliza https. Además se debe modificar el web.config para utilizar netTcpBinding
                if (ConfigurationManager.AppSettings["CertificadoSeguridad"] != null && ConfigurationManager.AppSettings["CertificadoSeguridad"].Length > 0)
                {
                    X509Store store = new X509Store(StoreLocation.CurrentUser);
                    store.Open(OpenFlags.ReadOnly | OpenFlags.OpenExistingOnly);

                    X509Certificate2Collection certificates = store.Certificates;
                    
                    X509Certificate2Collection foundCertificates = certificates.Find(X509FindType.FindBySubjectName, "DESKTOP-PSP09CG.andalucia.fin.ec", false);
                    
                    //X509Certificate2Collection selectedCertificates = X509Certificate2UI.SelectFromCollection(foundCertificates,"Selecciona un certificado.", "Selecciona un certificado de la siguiente lista:", X509SelectionFlag.SingleSelection);


                    svc.ClientCredentials.ClientCertificate.SetCertificate(StoreLocation.LocalMachine, StoreName.My, X509FindType.FindBySubjectName,
                        ConfigurationManager.AppSettings["CertificadoSeguridad"]);
                    System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;        // Se requiere instalar el DotNet Framework 4.5
                }

                correo.CodigoAplicacion = txtAplicacion.Text;//codigo de Aplicacion Asignada
                System.Collections.Generic.Dictionary<string, string> parametros = new System.Collections.Generic.Dictionary<string, string>();

                parametros.Add("Nombre", "Adrian Loya Pachacama");
                parametros.Add("Descripcion", "Este es una prueba de envio de correo por aplicacion.");
                //string[] anexos = new string[] {  };
                var respuesta = svc.EnviarCorreo(correo, "Esto es una prueba de envio de correo nueva aplicacion", parametros, null);
                if (respuesta.Resultado == 0)
                {
                    txtresultado.Text = "Exito";
                }
                else
                {
                    txtresultado.Text = "Codigo: " + respuesta.Resultado + ". Error: " + respuesta.Mensaje + ".";
                }
            }
            catch (Exception ex) {
                txtresultado.Text = ex.Message;
            }
        }
    }
}
