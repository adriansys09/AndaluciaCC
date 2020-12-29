using System;
using System.Collections.Generic;
using System.Web.UI;
using INFO;
using LOGI;

namespace ProyectoAndalucia.Referidos
{
    public partial class DatosReferidos : System.Web.UI.Page
    {
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
        //String menu = "REF8";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
                Referidos();
                inicializa("Elementos");
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
        }

        public void inicializa(string opcion)
        {
            switch (opcion)
            {
                case "Elementos":
                    if (gvReferidos.Rows.Count.Equals(0))
                    {
                        imgReferidos.Visible = false;
                        lblMensajeProductos.Text = "Al momento no cuenta con referidos.";
                    }
                    else
                    {
                        imgReferidos.Visible = true;
                        lblMensajeProductos.Text = "";
                    }
                    break;
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


        public void Referidos()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            string usuario = idUsuario + "";
            gvReferidos.DataSource = LogRef.rf_ReferidoEmpleado("RFE", idUsuario);
            gvReferidos.DataBind();
            gvReferidos.Columns[0].Visible = false; // Oculto ID
            gvReferidos.Columns[3].Visible = false; // Oculto ID
            gvReferidos.Columns[7].Visible = false; // Oculto ID
        }

        private void ExportGridToExcel(string nombre)
        {
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + nombre + " " + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/" + nombre + " " + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + ".xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            gvReferidos.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }

        protected void imgReferidos_Click(object sender, ImageClickEventArgs e)
        {
            ExportGridToExcel("ReporteReferidos");
        }
    }
}