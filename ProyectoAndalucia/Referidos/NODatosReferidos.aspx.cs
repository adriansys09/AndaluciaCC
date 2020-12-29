using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Referidos_DatosReferidos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            sesion();
        }
    }
    public void sesion()
    {
        if (ProyectoAndalucia.Inicio.IdUsuario == 0)
        {
            Response.Redirect("~/Inicio.aspx");
        }
    }
}