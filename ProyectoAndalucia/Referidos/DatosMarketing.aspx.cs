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
    public partial class DatosMarketing : System.Web.UI.Page
    {
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
        //String menu = "REF5";
        string empleado = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
                DatosPremios();
                inicializa("Elementos");
            }
        }
        // Requerido para guardar en excel
        public override void VerifyRenderingInServerForm(Control control)
        {
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
                case "Elementos":
                    if (gvPremiosCanje.Rows.Count.Equals(0))
                    {
                        imgPremiosCanje.Visible = false;
                        lblMensajeProductos.Text = "No existen solicitudes de canje.";
                    }
                    else
                    {
                        imgPremiosCanje.Visible = true;
                        lblMensajeProductos.Text = "";
                    }

                    if (gvPremiosEntregados.Rows.Count.Equals(0))
                    {
                        imgPremiosEntregados.Visible = false;
                        lblMensajeEntregados.Text = "No existen premios entregados.";
                    }
                    else
                    {
                        imgPremiosEntregados.Visible = true;
                        lblMensajeEntregados.Text = "";
                    }
                    break;
            }
        }
        public void DatosPremios()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();

            gvPremiosCanje.DataSource = LogRef.rf_canje_premios("PRQ", "PRI");
            gvPremiosCanje.DataBind();
            gvPremiosCanje.Columns[1].Visible = false; // Oculto ID
            gvPremiosCanje.Columns[3].Visible = false; // Oculto ID
            gvPremiosCanje.Columns[9].Visible = false; // Oculto ID
        // Carga Grid de impresion de Excel
            gvImprimePremiosCanje.DataSource = LogRef.rf_canje_premios("PRQ", "PRI");
            gvImprimePremiosCanje.DataBind();

            gvPremiosEntregados.DataSource = LogRef.rf_canje_premios("PRQ", "PRE");
            gvPremiosEntregados.DataBind();
            gvPremiosEntregados.Columns[1].Visible = false; // Oculto ID
            gvPremiosEntregados.Columns[2].Visible = false; // Oculto ID
            gvPremiosEntregados.Columns[8].Visible = false; // Oculto ID

        }



        public void mostrarproductos()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();

            //        gvProdActivos.DataSource = LogRef.rf_puntos_colaborador("PC");
            //gvProdActivos.DataBind();

        }

        protected void gvMarketing_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvPremiosCanje.SelectedRow;
            empleado = row.Cells[3].Text;

            ContactoEmpleado(empleado);

        }
        public void ContactoEmpleado(string emp)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listEmpleado = new List<ReferidosInfo>();

            listEmpleado = LogRef.rf_datos_empleado("LSE", emp);  // Revisar si es necesario
            

        }


        protected void gvPremiosCanje_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Validar")
            {
                ActualizarEstado();
            }
        }

        private void ExportGridToExcel(string nombre)
        {
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + nombre + " " + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/" + nombre + " " + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + ".xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

            if (nombre == "Premios Canje")
                gvImprimePremiosCanje.RenderControl(htmlWrite);
            else if (nombre == "Premios Entregados")
                gvPremiosEntregados.RenderControl(htmlWrite);

            Response.Write(stringWrite.ToString());
            Response.End();

        }


        public void ActualizarEstado()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            string listInsertEstado = "";
            string listInsertLog    = "";

            //string estadoPuntos = "REF";
            string estadoPremio = "E";
            string id = "";
            //int user = 0;
            string cuenta = "";
            string Observacion = "";

            try
            {
                if (gvPremiosCanje.SelectedRow != null)
                {
                    GridViewRow row = gvPremiosCanje.SelectedRow;
                    id = row.Cells[1].Text;
                    empleado = row.Cells[3].Text;
                    cuenta = row.Cells[3].Text;
                    Observacion = row.Cells[10].Text;
                }
                if (id != "")
                {
                    listInsertEstado = LogRef.rf_UpdateEstadoReg("UPP", id, empleado, cuenta, estadoPremio);    // ESTADO PREMIOS COLABORADOR - Solo requiere ID y ENTE
                    listInsertLog = LogRef.rf_InsertLog("ILOG", idUsuario, empleado, "", "MARK1", "Registra la entrega del premio.");
                    DatosPremios();// Recarga Tabla
                    inicializa("Elementos");
                }
                else
                    lblMensajeProductos.Text = "Seleccione un registro";


            }
            catch (Exception)
            {

                throw;
            }


        }

        protected void imgPremiosCanje_Click(object sender, ImageClickEventArgs e)
        {
            ExportGridToExcel("Premios Canje");
        }

        protected void imgPremiosEntregados_Click(object sender, ImageClickEventArgs e)
        {
            ExportGridToExcel("Premios Entregados");
        }
    }
}