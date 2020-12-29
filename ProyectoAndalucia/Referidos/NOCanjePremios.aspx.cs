using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using INFO;
using LOGI;

namespace ProyectoAndalucia.Referidos
{
    public partial class CanjePremios : System.Web.UI.Page
    {
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
       // String menu = "REF2";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
            }
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
        public void inicializa(string opcion)
        {
            switch (opcion)
            {
                case "Variables":
                    {
                        idRolUsuario.Clear();
                    }
                    break;
            }
        }
    }

}