using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Threading;
using System.Drawing;
using System.Windows.Forms;
using System.Web;
using System.Timers;
using WinSvcAndaluciaCuadre.CargarDatosSvc;

namespace WinSvcAndaluciaCuadre
{
    public partial class CuadreConableSvc : ServiceBase
    {
        private static string strSource = ConfigurationManager.AppSettings["NombreLog"];
        private static string Aplicacion = ConfigurationManager.AppSettings["NroAplicacion"];
        public static List<String> errores = new List<String>();
        public static string pathLog = "";
        private System.Timers.Timer temporizador = null;
        string fecha = "";
        string mensaje = "";
        string hC = ConfigurationManager.AppSettings["horaEjecucion"];       //Recupera la hora programada para la comprobación del App.config
        public enum ServiceState
        {
            SERVICE_STOPPED = 0x00000001,
            SERVICE_START_PENDING = 0x00000002,
            SERVICE_STOP_PENDING = 0x00000003,
            SERVICE_RUNNING = 0x00000004,
            SERVICE_CONTINUE_PENDING = 0x00000005,
            SERVICE_PAUSE_PENDING = 0x00000006,
            SERVICE_PAUSED = 0x00000007,
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct ServiceStatus
        {
            public int dwServiceType;
            public ServiceState dwCurrentState;
            public int dwControlsAccepted;
            public int dwWin32ExitCode;
            public int dwServiceSpecificExitCode;
            public int dwCheckPoint;
            public int dwWaitHint;
        };
    
        public CuadreConableSvc()
        {
            InitializeComponent();
            try
            {
                temporizador = new System.Timers.Timer(int.Parse(ConfigurationManager.AppSettings["IntervaloMilisegundos"]));                          //86.400.000 milisegundos = 24 horas
                temporizador.Elapsed += new ElapsedEventHandler(temporizador_Elapsed);  //Agregamos el manejador de eventos para la ejecución del código cuando pase el tiempo indicado
            }
            catch (Exception ex)
            {
                fecha = DateTime.Now.ToLocalTime().ToString();
                string mensaje = Environment.NewLine + fecha + ex.TargetSite + " - " + ex.Message; //Construimos el mensaje en caso de error

            }
            eventLog = new EventLog();
            if (!System.Diagnostics.EventLog.SourceExists("CuadreContable"))
            {
                EventLog.CreateEventSource("CuadreContable", "Aplication");
            }
            eventLog = new EventLog();
            eventLog.Source = strSource;
            eventLog.Log = "Application";
        }
        [DllImport("advapi32.dll", SetLastError = true)]
        private static extern bool SetServiceStatus(System.IntPtr handle, ref ServiceStatus serviceStatus);

        protected override void OnStart(string[] args)
        {

            pathLog = ConfigurationManager.AppSettings["pathLog"] + "Log_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";
            // Update the service state to Start Pending.
            ServiceStatus serviceStatus = new ServiceStatus();
            serviceStatus.dwCurrentState = ServiceState.SERVICE_START_PENDING;
            serviceStatus.dwWaitHint = 100000;
            SetServiceStatus(this.ServiceHandle, ref serviceStatus);

            System.Net.ServicePointManager.DefaultConnectionLimit = 7;      // Hasta 7 conexiones

            eventLog.WriteEntry("Inicia el Servicio Carga Tablas Cuadre Contable v. 2020-09-09");
            eventLog.WriteEntry("Intervalo: " + ConfigurationManager.AppSettings["IntervaloMilisegundos"]);
            try
            {
                //System.Timers.Timer timer = new System.Timers.Timer();
                //timer.Interval = int.Parse(ConfigurationManager.AppSettings["IntervaloMilisegundos"]);
                //timer.Elapsed += new System.Timers.ElapsedEventHandler(this.OnTimer);
                //temporizador.Elapsed += new System.Timers.ElapsedEventHandler(temporizador_Elapsed);
                temporizador.Start();

                //// Update the service state to Running.
                serviceStatus.dwCurrentState = ServiceState.SERVICE_RUNNING;
                SetServiceStatus(this.ServiceHandle, ref serviceStatus);
               
            }
            catch (Exception ex)
            {
                eventLog.WriteEntry("Excepcion al iniciar Carga Tablas Cuadre Contable: " + ex.Message);
            }
        }

        protected override void OnStop()
        {
            eventLog.WriteEntry("Finaliza el Servicio Carga Tablas Cuadre Contable");
        }

        private int eventId = 1;

        public void OnTimer(object sender, System.Timers.ElapsedEventArgs args)
        {
            fnEjecutarProcesos();
        }
        private void stLapso_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {

        }
        void temporizador_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            try
            {
                //Va comprobando la hora y lanza el proceso a la hora especificada
                hC = System.Configuration.ConfigurationManager.AppSettings["horaEjecucion"];
                string horaStma = DateTime.Now.ToShortTimeString();
                fecha = DateTime.Now.ToLocalTime().ToString();
                if (horaStma == hC)
                {
                    eventLog.WriteEntry("Inicia el Servicio Carga Tablas Cuadre Contable RUNNING."+ DateTime.Now.ToLocalTime().ToString());

                    
                    //eventLog.WriteEntry("Inicia ejecucion Servicio." + " Hora comprobación: " + hC + ".    Hora sistema: " + horaStma);
                    //Detiene el timer

                    temporizador.Enabled = false;
                    //Lanzamos el proceso que nos interese ejecutar
                    fnEjecutarProcesos();
                    //Volvemos a habilitar el timer para que empiece a contar otra vez
                    eventLog.WriteEntry("Fin  Carga Tablas Cuadre Contable RUNNING. "+ DateTime.Now.ToLocalTime().ToString());
                    temporizador.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                eventLog.WriteEntry("Excepcion al Ejecutar la Carga Tablas Cuadre Contable: " + ex.Message);
            }
        }

        private void fnEjecutarProcesos()
        {
            DateTime fechaCalendario = new DateTime();
            fechaCalendario = DateTime.Now;
            //DateTime fechaSd = new DateTime();

            System.DateTime.Now.DayOfWeek.ToString();
            CargarDatosSvc.clsCargaDatos param = new CargarDatosSvc.clsCargaDatos();
            CargarDatosSvc.clsResultado resultado = new CargarDatosSvc.clsResultado();
            CargarDatosSvc.clsFiltro filtro = new CargarDatosSvc.clsFiltro();

            CargarDatosSvc.CargaDatosSvcClient svc = new CargarDatosSvc.CargaDatosSvcClient();
            //Consulta de las fechas saldo diario y fecha de cierre o corte
            filtro.Modo = 0;
            filtro.Filtro = "";
            svc.CargarDataFechas(filtro, out resultado);

            if (resultado.Resultado != 0) {
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    eventLog.WriteEntry("ERROR CONSULTA DE FECHAS DE CIERRE Y SALDOS DIARIOS: " + "   " + resultado.Mensaje, EventLogEntryType.Error, 0);
                    errores.Add(resultado.Mensaje);
                    System.IO.File.WriteAllLines(pathLog, errores);
                    fnEnviarCorreo();
                    return;
                }
            }
            param.FechaSd = resultado.FechaSd;
            param.FechaCierre = resultado.FechaCierre;
            
            var date = fechaCalendario;//resultado.FechaSd;// fecha.Value.DayOfWeek.ToString();
            ///Valida si es Fin de mes
            //se obtiene primer dia del mes
            DateTime oPrimerDiaDelMes = new DateTime(date.Year, date.Month, 1);
            //Y de la siguiente forma obtenemos el ultimo dia del mes 
            //agregamos 1 mes al objeto anterior y restamos 1 día.
            DateTime oUltimoDiaDelMes = oPrimerDiaDelMes.AddMonths(1).AddDays(-1);
            ///comparamos la fecha obtenida con el ultimo dia del mes
            if(fechaCalendario.Day== oUltimoDiaDelMes.Day)
            //if (resultado.FechaCierre.Value.Day == oUltimoDiaDelMes.Day)
            {
                //validar si es feriado o dia no habil
                //var diaHabil = fnDiasNoHabiles(resultado.FechaCierre, oPrimerDiaDelMes, oUltimoDiaDelMes);
                param.Finmes = "S";
                param.Fechadesde = oPrimerDiaDelMes;
                param.FechaHasta = oUltimoDiaDelMes;
                //var diaHabil = fnDiasNoHabiles(fechaCalendario, oPrimerDiaDelMes, oUltimoDiaDelMes);
                //if (diaHabil == "N")
                //{
                //    param.FechaHasta = resultado.FechaCierre;
                //}
                //else {
                //    param.FechaHasta = oUltimoDiaDelMes;
                //}
            }
            else
            {
                var diaHabil = fnDiasNoHabiles(Convert.ToDateTime(fechaCalendario.ToShortDateString()), oPrimerDiaDelMes, oUltimoDiaDelMes);
                if (diaHabil == "S")
                {
                    param.Finmes = "N";
                    param.Fechadesde = param.FechaHasta = resultado.FechaCierre;
                }
                else
                {
                    eventLog.WriteEntry("Dia no Habil." + DateTime.Now.ToLocalTime().ToString());
                    return;
                }
            }

            //CONSULTA 2105 PF
            param.DiasIni = 0;
            eventLog.WriteEntry("Inicia Carga 2105 PF." + DateTime.Now.ToLocalTime().ToString());
            svc.CargarData2105PF(param, out resultado);

            if (resultado.Resultado != 0)
            {
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    string errorRecibido = "ERROR EN EL PROCESO DE CARGA 2105 PF: " + "   " + resultado.Mensaje;
                    eventLog.WriteEntry(errorRecibido, EventLogEntryType.Error, 0);
                    errores.Add(errorRecibido);

                }

            }
            eventLog.WriteEntry("Fin Carga 2105 PF." + DateTime.Now.ToLocalTime().ToString());
            //CONSULTA 2103
            eventLog.WriteEntry("Inicia Carga 2103 PF." + DateTime.Now.ToLocalTime().ToString());
            param.DiasIni = 0;
            svc.CargarData2103(param, out resultado);

            if (resultado.Resultado != 0)
            {
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    string errorRecibido = "ERROR EN EL PROCESO DE CARGA 2103: " + "   " + resultado.Mensaje;
                    eventLog.WriteEntry(errorRecibido, EventLogEntryType.Error, 0);
                    errores.Add(errorRecibido);

                }

            }
            eventLog.WriteEntry("Fin Carga 2103 PF." + DateTime.Now.ToLocalTime().ToString());

            //CONSULTA 2105
            eventLog.WriteEntry("Inicia Carga 2105 AHORRO." + DateTime.Now.ToLocalTime().ToString());
            param.Encaje = "S";
            svc.CargarData2105(param, out resultado);

            if (resultado.Resultado != 0)
            {
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    string errorRecibido = "ERROR EN EL PROCESO DE CARGA 2105: " + "   " + resultado.Mensaje;
                    eventLog.WriteEntry(errorRecibido, EventLogEntryType.Error, 0);
                    errores.Add(errorRecibido);

                }

            }
            eventLog.WriteEntry("Fin Carga 2105 ahorro." + DateTime.Now.ToLocalTime().ToString());
            ////CONSULTA 2101

            eventLog.WriteEntry("Inicia Carga 2101 AHORRO." + DateTime.Now.ToLocalTime().ToString());
            svc.CargarData2101(param,out resultado);

            if (resultado.Resultado != 0)
            {
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    string errorRecibido = "ERROR EN EL PROCESO DE CARGA 2101: " + "   " + resultado.Mensaje;
                    eventLog.WriteEntry(errorRecibido, EventLogEntryType.Error, 0);
                    errores.Add(errorRecibido);
                }

            }
            eventLog.WriteEntry("FIN Carga 2101 AHORRO." + DateTime.Now.ToLocalTime().ToString());

            //CONSULTA 210150
            eventLog.WriteEntry("Inicia Carga 210150 AHORRO." + DateTime.Now.ToLocalTime().ToString());
            svc.CargarData210105(param, out resultado);

            if (resultado.Resultado != 0)
            {
                using (EventLog eventLog = new System.Diagnostics.EventLog("Application", Environment.MachineName, strSource))
                {
                    string errorRecibido = "ERROR EN EL PROCESO DE CARGA 210150: " + "   " + resultado.Mensaje;
                    eventLog.WriteEntry(errorRecibido, EventLogEntryType.Error, 0);
                    errores.Add(errorRecibido);

                }

            }

            eventLog.WriteEntry("FIN Carga 210150 AHORRO." + DateTime.Now.ToLocalTime().ToString());

            //GENERAR LOG SI LA LISTA NO ESTA VACÍA 
            if (errores.Count > 0)
            {
                System.IO.File.WriteAllLines(pathLog, errores);
                fnEnviarCorreo();
            }



        }

        private object fnDiasNoHabiles(DateTime? fechaCierre)
        {
            throw new NotImplementedException();
        }

        private String fnDiasNoHabiles(DateTime? fechaCierre, DateTime oPrimerDiaDelMes, DateTime oUltimoDiaDelMes)
        {
            string DiaHabil = "S";
            
            CargarDatosSvc.clsResultado resultado = new CargarDatosSvc.clsResultado();
            CargarDatosSvc.clsFiltro filtro1 = new CargarDatosSvc.clsFiltro();
            CargarDatosSvc.CargaDatosSvcClient svcDiasHabiles = new CargarDatosSvc.CargaDatosSvcClient();

            //List<CargarDatosSvc.clsDiasFeriados> diasHabiles = new List<CargarDatosSvc.clsDiasFeriados>();
            filtro1.Modo = 1;
            filtro1.Filtro = "df_fecha>='" + Convert.ToDateTime(oPrimerDiaDelMes.ToString()).ToString("MM/dd/yyyy") + "' and df_fecha <='" + Convert.ToDateTime(oUltimoDiaDelMes.ToString()).ToString("MM/dd/yyyy") + "' and df_ciudad = 1706";
            var diasHabiles = svcDiasHabiles.CargarDataFechas(filtro1,out resultado);
            for (int i = 0; i < diasHabiles.Length; i++) {
                if(fechaCierre== diasHabiles[i].Fecha)
                {
                    DiaHabil = "N";
                    break;
                }
            }
            
            return DiaHabil;
        }

       

        private void fnEnviarCorreo(){
            
            SvcEnviarCorreo.NotificadorClient envioCorreo = new SvcEnviarCorreo.NotificadorClient();
            SvcEnviarCorreo.clsCorreoAplicacion DatosCorreo = new SvcEnviarCorreo.clsCorreoAplicacion();
            System.Collections.Generic.Dictionary<string, string> parametros = new System.Collections.Generic.Dictionary<string, string>();
            DatosCorreo.CodigoAplicacion = Aplicacion;
            parametros.Add("Nombre", "");
            parametros.Add("Descripcion", "El documento con las novedades generadas en el proceso de Ejecucion de la carga de tablas de cuadre contable");
            string[] anexos = new string[] { pathLog };
            try
            {
                var res = envioCorreo.EnviarCorreo(DatosCorreo, "Novedades del servicio de carga uadre contable", parametros, anexos);
            }
            catch (Exception ex) {
                errores.Add(ex.Message);
                System.IO.File.WriteAllLines(pathLog, errores);
                string errorRecibido = "ERROR EN ENVÍO CORREO: "+ex.Message;
                eventLog.WriteEntry(errorRecibido, EventLogEntryType.Error, 0);
                errores.Add(errorRecibido);
            }

        }
    }
}
