using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using INFO;
using LOGI;

public partial class Datos_Personales : System.Web.UI.Page
{
    // Variables de inicio de sesion
    int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
    int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
    List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
    //String menu = "UC4";
   // string empleado = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        sesion();
    }

    // Sesion Usuario
    public void sesion()
    {
        ReferidosLogi LogRef = new ReferidosLogi();
        List<ReferidosInfo> listRoles = new List<ReferidosInfo>();
        //inicializa("Variables");
        int a = 0;

        List<int> idRolUsuario = new List<int>();
        idRolUsuario.Clear();

        // Valida Usuario Acceso
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;

        if (idUsuario == 0)
        {
            Response.Redirect("~/Inicio.aspx");
        }

        // Valida Rol Acceso
        for (int j = 0; j < idRolUsuario.Count; j++)
        {
            if (idRolUsuario[j] != idRolAcceso)
            {
                a = 0;
            }
            else
            {
                a = 1;
                break;
            }
        }
        if (a == 0)
        {
            //                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Acceso no permitido');", true);
            Response.Redirect("~/Inicio.aspx");
        }
    }

    protected void Abrir_Click(object sender, EventArgs e)
    {
        string vtn = "window.open('login.aspx','Dates','scrollbars=yes,resizable=yes','height=300', 'width=300')";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", vtn, true);
    }

}