using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Drawing;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using INFO;
using LOGI;
using System.Data;
using System.Configuration;

namespace ProyectoAndalucia
{

    public partial class Inicio : System.Web.UI.Page
    {
        List<ReferidosInfo> listAcceso = new List<ReferidosInfo>();


        // Variables de Sesion
        public static string NombreUsuario { get; set; } = string.Empty;
        public static string CedulaUsuario { get; set; } = string.Empty;
        public static string Usuario { get; set; } = string.Empty;
        public static int IdUsuario { get; set; } = 0;
        public static string CorreoUsuario { get; set; } = string.Empty;
        public static string FotoUsuario { get; set; } = string.Empty;
        public static int RolAcceso { get; set; } = 0;

        public static List<int> RolUsuario = new List<int>();

        //public static int      IdUsuario = 0;
        //public string   NombreUsuario   = "";
        //public string   cl_nombre   = "";
        //public string   FotoUsuario = "";
        //public int      RolUsuario = 0;
        //public string   CorreoUsuario = "";
        //public string   Usuario = "";
        string pass     = "";
        bool permiso    = false;
        int ini = 0;            /* inicio de nombre del empleado*/

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                inicializa_variables();
                carga_rol();
                fnLeerCookie();
            }
        }

        // FUNCIONES
        // Inicia Variables
        public void inicializa_variables()
        {
            lblMensaje.Text = "";
            lblClave.Visible = true;
            lblRol.Visible = true;
            lblUser.Text = "USUARIO:";
            txtClave.Visible = true;
            txtUsuario.Text = "";
            txtCedula.Text = "";
            txtCedula.Visible = false;
            ddlRol.Visible = true;
            btnIngresar.Visible = true;
            btnCedula.Visible = false;
            

            // Script Oculta DIV Mensajes
            String ScriptAct = "HiddenMap();";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HiddenMap()", ScriptAct, true);
        }

        // Obtiene Roles
        public void carga_rol()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listRoles = new List<ReferidosInfo>();
            try
            {
                //listRoles = LogRef.rf_ListarRoles("RS");
                //[9:39] Andres Salazar
                listRoles = LogRef.rf_ListarRoles("RC");

                //foreach (ReferidosInfo detalle in listRoles)
                //{
                //   string cad =  detalle.Descripcion;
                //}
                ddlRol.DataSource = listRoles;
                ddlRol.DataTextField = "rl_descripcion";
                ddlRol.DataValueField = "rl_codigo";
                ddlRol.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        

        // Obtiene Datos de empleado
        public void consulta_empleado()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listEmpleado = new List<ReferidosInfo>();
            try
            {
                List<RefClienteInfo> listaEmp = new List<RefClienteInfo>();
                RefClienteInfo emples = new RefClienteInfo();
                string[] Nombres = Usuario.Split('.');
                listaEmp = LogRef.ConsultarEmpleado("Q", "", Nombres[0].ToUpper(), Nombres[1].ToUpper());
                emples = (RefClienteInfo)listaEmp[0];
                int idUsuario = emples.Ente;
                HttpContext.Current.Session["LoginId"] = idUsuario;
                /* Mala : para la variable de session */
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        //Autentica AD - Funcional pero está integrado en funcion validadatos
        private bool AutenticaUsuario(String path, String user, String pass)
        {
            DirectoryEntry de = new DirectoryEntry(path, user, pass, AuthenticationTypes.Secure);
            try
            {
                DirectorySearcher ds = new DirectorySearcher(de);
                ds.FindOne();
                return true;
            }
            catch
            {
                return false;
            }
        }



        // Valida Cedula y Login
        public bool validadatos(string valida)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();

            bool respuesta = false;

            try
            {
                //Valida Cedula
                if (valida == "cedula")
                {
                    if (LogRef.validadorDeCedula(txtCedula.Text).Trim().Equals(""))
                    {
                        respuesta = true;
                    }
                    return respuesta;
                }
                else if (valida == "vUserRef")
                {


                    string properString = "Hello World!";
                    Console.WriteLine(properString.ToLower());

                    //Consulta datos de Usuario del sistema Referidos
                    listAcceso = LogRef.rf_ValidaUsuarioR("CS", "CSL",  txtUsuario.Text.ToLower());
                    foreach (ReferidosInfo datosUsuarioR in listAcceso)
                    {
                        /*Llena datos de sesion*/
                        IdUsuario = datosUsuarioR.Us_ente;
                        CedulaUsuario   = datosUsuarioR.Us_cedula;
                        NombreUsuario  = datosUsuarioR.Us_nombres;
                        FotoUsuario    = datosUsuarioR.Us_foto;
                        RolAcceso   = Int32.Parse(ddlRol.SelectedValue.ToString());
                        CorreoUsuario = txtUsuario.Text.ToLower() + "@andalucia.fin.ec";

                        return respuesta = true;
                    }
                        return respuesta;
                }
                else if (valida == "vlogin")
                {
                    //Consulta datos de Usuario del sistema Referidos
                    listAcceso = LogRef.rf_ValidaAcceso("CS", "CSE", txtUsuario.Text.ToLower(), txtClave.Text);
                    foreach (ReferidosInfo datosAcceso in listAcceso)
                    {
                        /*Llena datos de sesion*/
                        IdUsuario = datosAcceso.Us_ente;
                        CedulaUsuario = datosAcceso.Us_cedula;
                        NombreUsuario = datosAcceso.Us_nombres;
                        FotoUsuario = datosAcceso.Us_foto;
                        RolAcceso = Int32.Parse(ddlRol.SelectedValue.ToString());
                        //CorreoUsuario = "servivio.cliente@andalucia.fin.ec"; // Correo Usuario Externo

                        return respuesta = true;
                    }
                    return respuesta;
                }
                else
                    return respuesta;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        
        public bool validacedularuc(string cedula)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            //GnrConexionLogi LogGen = new GnrConexionLogi();
            bool respuesta = false;

            if (LogRef.validadorDeCedula(cedula).Trim().Equals(""))
            {
                respuesta = true;
            }
            return respuesta;

        }


        protected void btnCedula_Click(object sender, EventArgs e)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            string listInsertE = "";

            try
            {
                //Obtengo datos guardados de usuario
                NombreUsuario = txtUsuario.Text.ToLower();
                CorreoUsuario = txtUsuario.Text.ToLower() + "@andalucia.fin.ec";

                if (validacedularuc(txtCedula.Text) == true)
                {
                    /*INSERTA DATOS DE USUARIO - SIST REFERIDOS*/
                    listInsertE = LogRef.rf_InsertEmpleado("IE", txtCedula.Text, NombreUsuario, CorreoUsuario);
                    accedemenu();
                }
                else
                {
                    lblMensaje.Text = "Cedula incorrecta";
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            List<ReferidosInfo> listRoles = new List<ReferidosInfo>();

            RolUsuario.Clear();
            string Usuario2 = "";

            string dominio  = LogRef.dominio.ToString();
            string path     = LogRef.path.ToString();
            Usuario = txtUsuario.Text.ToLower().Trim();
            pass    = txtClave.Text.Trim();
            string domUsu = dominio + @"\" + Usuario;

            /* 1 - Valida Usuario AD*/
            permiso = AutenticaUsuario(path, domUsu, pass);

            if (permiso == true) /*Es Usuario AD*/
            {
                if (validadatos("vUserRef") == false)/* 1.1 - Valida Usuario Existe - Sis Ref*/
                {

                    /*Consulta Cobis*/
                    lblClave.Visible = false;
                    lblRol.Visible = false;
                    lblUser.Text = "CÉDULA :";
                    txtUsuario.Visible = false;
                    txtClave.Visible = false;
                    ddlRol.Visible = false;
                    txtCedula.Visible = true;
                    btnCedula.Visible = true;
                    btnIngresar.Visible = false;

                    lblMensaje.Text = "Ingrese su cédula para validar sus datos";
                }
                else
                {
                    // VALIDA ROL
                    // OBTIENE ROL-OFICIAL
                    listRoles = LogRef.rf_ValidaRoles("RUS", IdUsuario);
                    foreach (ReferidosInfo RolesO in listRoles)
                    {
                        RolUsuario.Add(RolesO.Ru_rol); //Llena tabla RolUsuario                        
                    }
                    
                    int a = 0;
                    // Valida Rol Acceso
                    for (int j = 0; j < RolUsuario.Count; j++)
                    {
                        if (RolUsuario[j] != RolAcceso)
                        {
                            a = 0;
                        }
                        else
                        {
                            a = 1;
                            break;
                        }
                    }
                    if (a == 1)
                    {
                        accedemenu();       // Accede al menu
                    }
                    else
                    {
                        //MENSAJE: Busca el usuario para responder.
                        if (Usuario.IndexOf(".") == 0)
                        {
                            lblMensaje.Text = "Hola " + Usuario.Substring(ini, Usuario.IndexOf(".")).ToUpperInvariant() + ", " + "el rol no está permitido";
                        }
                        else
                        {
                            Usuario2 = Usuario + ".";
                            lblMensaje.Text = "Hola " + Usuario2.Substring(ini, Usuario2.IndexOf(".")).ToUpperInvariant() + ", " + "el rol no está permitido";
                        }
                    }



                }
            }
            /* 2 - Validación de Usuario Externo*/
            if (permiso == false)
            {
                if (validadatos("vlogin") == false)/* 1.2 - Valida Usuario Externo Existe*/
                {
                    //Busca el usuario para responder en el mensaje.
                    if (Usuario.IndexOf(".") == 0)
                    {
                        lblMensaje.Text = "Hola " + Usuario.Substring(ini, Usuario.IndexOf(".")).ToUpperInvariant() + ", " + "el usuario o clave son incorrectos, vuelve a intentar";
                    }
                    else
                    {
                        Usuario2 = Usuario + ".";
                        lblMensaje.Text = "Hola " + Usuario2.Substring(ini, Usuario2.IndexOf(".")).ToUpperInvariant() + ", " + "el usuario o clave son incorrectos, vuelve a intentar";
                    }
                }
                else /*Si Login Ext. true*/
                {
                    // VALIDA ROL
                    // OBTIENE ROL-OFICIAL
                    listRoles = LogRef.rf_ValidaRoles("RUS", IdUsuario);
                    // Carga Variable Global Rol
                    foreach (ReferidosInfo RolesO in listRoles)
                    {
                        RolUsuario.Add(RolesO.Ru_rol); //Llena tabla RolUsuario                        
                    }
                    
                    int a = 0;
                    // Valida Rol Acceso
                    for (int j = 0; j < RolUsuario.Count; j++)
                    {
                        if (RolUsuario[j] != RolAcceso)
                        {
                            a = 0;
                        }
                        else
                        {
                            a = 1;
                            break;
                        }
                    }
                    if (a == 1)
                    {
                        accedemenu();       // Accede al menu
                    }
                    else
                    {
                        //MENSAJE: Busca el usuario para responder.
                        if (Usuario.IndexOf(".") == 0)
                        {
                            lblMensaje.Text = "Hola " + Usuario.Substring(ini, Usuario.IndexOf(".")).ToUpperInvariant() + ", " + "el rol no está permitido";
                        }
                        else
                        {
                            Usuario2 = Usuario + ".";
                            lblMensaje.Text = "Hola " + Usuario2.Substring(ini, Usuario2.IndexOf(".")).ToUpperInvariant() + ", " + "el rol no está permitido";
                        }
                    }
                }
            }
        }

        public void accedemenu()
        {

            try
            {
                lblMensaje.ForeColor = Color.SkyBlue;
                //lblMensaje.Text = "BIENVENIDO " + Usuario.Substring(ini, Usuario.IndexOf(".")).ToUpperInvariant();

                string rol;
                rol = ddlRol.SelectedItem.Text;
                Session["Login"] = txtUsuario.Text;
                Session["rol"] = ddlRol.SelectedValue;
                fnCrearCookie();

                switch (rol)
                {
                    case "ADMINISTRADOR":
                        Response.Redirect("Referidos/AdministradorReferidos.aspx", false);
                        break;
                    case "OFICIAL DE NEGOCIOS":
                        Response.Redirect("Referidos/RegistroProducto.aspx", false);
                        break;
                    case "COLABORADOR":
                        Response.Redirect("Referidos/ConsultaPuntos.aspx", false);
                        break;
                    case "MARKETING":
                        Response.Redirect("Referidos/DatosMarketing.aspx", false);
                        break;
                    case "CALLCENTER":
                        Response.Redirect("Referidos/DatosCallcenter.aspx", false);
                        break;
                    case "ACTUALIZACION DATOS":
                        Response.Redirect("Datos/DatosPersonales.aspx", false);
                        break;
                    case "CUADRE CONTABLE":
                        Response.Redirect("Cuadres/CuadrePrincipal.aspx", false);
                        break;
                    default:
                        lblMensaje.Text = "Seleccione un rol";
                        break;

                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        private void fnCrearCookie()
        {
            try
            {
                HttpCookie Cookie;
                if (Request.Cookies["PreferencesProyAndal"] == null)
                    Cookie = new HttpCookie("PreferencesProyAndal");
                else
                    Cookie = Request.Cookies["PreferencesProyAndal"];
                Cookie.Values.Set("Login", txtUsuario.Text);
                Cookie.Values.Set("Rol", ddlRol.SelectedValue);
                //Cookie.Values.Set("Oficina", ddlOficina.SelectedValue);
                Cookie.Expires = DateTime.Now.AddMonths(1);
                Response.AppendCookie(Cookie);
            }
            catch { /* No hacer nada si no acepta cookies */	}
        }
        /// <summary>
        /// Leer la cookie que contiene el último login con que han ingresado
        /// Así como también la empresa y la oficina utilizados
        /// </summary>
        private void fnLeerCookie()
        {
            try
            {
                if (Request.Cookies["PreferencesProyAndal"] != null)
                {
                    // lblMensaje.Text = "";

                    HttpCookie Cookie = Request.Cookies["PreferencesProyAndal"];
                    txtUsuario.Text = Cookie.Values["Login"];


                    // Seleccionar la oficina
                    string strrol = Cookie.Values["rol"];
                    int j = 0;
                    foreach (ListItem or in ddlRol.Items)
                    {
                        if (or.Value == strrol)
                        {
                            ddlRol.SelectedIndex = j;
                            break;
                        }
                        j += 1;
                    }
                    txtClave.Focus();
                }
                else
                {
                    //txtLogin.Text = "";
                    
                    ddlRol.SelectedIndex = 0;
                }
            }
            catch { /* No hacer nada si no acepta cookies */	}
        }
    }
}

