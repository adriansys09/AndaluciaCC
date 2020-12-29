using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using INFO;
using LOGI;
using System.Data;
//using System.Windows.Forms;

namespace ProyectoAndalucia.Referidos
{
    public partial class DatosCallcenter : System.Web.UI.Page
    {
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
        String menu = "REF4";

        string empleado = "";
        string cliente = "";

        DataTable dt = new DataTable();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
                DatosProductos();
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
                Response.Redirect("~/Inicio.aspx");
            }
        }

        protected void gvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            inicializa("Elementos");

            GridViewRow row = gvProductos.SelectedRow;
            empleado = row.Cells[8].Text;
            cliente = row.Cells[7].Text;

            ContactoEmpleado(empleado);
            ContactoCliente(cliente);
            productos_clientes(cliente);
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
                case "Elementos":
                    txtNombreE.Text = "";
                    txtNombreC.Text = "";
                    txtCorreoC.Text = "";
                    lblTipoProductoC.Text = "";
                    ddlProductos.Items.Clear();
                    ddlTelefonos.Items.Clear();
                    
                    if (gvProductos.Rows.Count.Equals(0))
                    {
                        imgPendientes.Visible = false;
                        lblMensajeProductos.Text = "No existen registros para verificar";
                    }
                    else
                    {
                        imgPendientes.Visible = true;
                        lblMensajeProductos.Text = "";
                    }
                        
                    if (gvRechazadas.Rows.Count.Equals(0))
                    {
                        imgRechazados.Visible = false;
                        lblMensajeRechazados.Text = "No existen registros.";
                    }
                    else
                    {
                        imgRechazados.Visible = true;
                        lblMensajeRechazados.Text = "";
                    }

                    break;
            }
        }

        public void DatosProductos()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listCliente = new List<ReferidosInfo>();
            GridViewRow row = gvRechazadas.SelectedRow;

            // Productos pendientes
            gvProductos.DataSource = LogRef.rf_registro_productos("LS");
            gvProductos.DataBind();
            gvProductos.Columns[1].Visible = false; // Oculto ID
            gvProductos.Columns[4].Visible = false; // Oculto Regla
            gvProductos.Columns[7].Visible = false; // Oculto Cliente
            gvProductos.Columns[8].Visible = false; // Oculto Empleado
            gvProductos.Columns[9].Visible = false; // Oculto Oficial

            // Productos Pendientes para impresion
            gvGuardarPendientes.DataSource = LogRef.rf_registro_productos("LS");
            gvGuardarPendientes.DataBind();
            gvGuardarPendientes.Columns[0].Visible = false; // Oculto ID
            gvGuardarPendientes.Columns[7].Visible = false; // Oculto Empleado
            gvGuardarPendientes.Columns[8].Visible = false; // Oculto Oficial

            // Productos rechazados
            gvRechazadas.DataSource = LogRef.rf_registro_productos("LSR");
            gvRechazadas.DataBind();
            gvRechazadas.Columns[0].Visible = false; // Oculto ID
            gvRechazadas.Columns[3].Visible = false; // Oculto ID
            gvRechazadas.Columns[7].Visible = false; // Oculto Empleado
        }

        public void ContactoEmpleado(string emp)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listEmpleado = new List<ReferidosInfo>();
            
            listEmpleado = LogRef.rf_datos_empleado("LSE", emp);
            foreach (ReferidosInfo detalle in listEmpleado)
            {
                txtNombreE.Text = detalle.Lse_nombre;
            }
        }
        public void ContactoCliente(string cli)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listCliente = new List<ReferidosInfo>();
            List<ReferidosInfo> listProducto = new List<ReferidosInfo>();

            ddlTelefonos.Items.Clear();
            listCliente = LogRef.rf_datos_cliente("LSC", cli);

            foreach (ReferidosInfo detalle in listCliente)
            {
                txtNombreC.Text = listCliente.ElementAt(0).Lsc_nombre;
                if(listCliente.ElementAt(0).Lsc_telefono1 != " ")
                    ddlTelefonos.Items.Add(listCliente.ElementAt(0).Lsc_telefono1);
                if (listCliente.ElementAt(0).Lsc_telefono2 != " ")
                    ddlTelefonos.Items.Add(listCliente.ElementAt(0).Lsc_telefono2);
                if (listCliente.ElementAt(0).Lsc_telefono3 != " ")
                    ddlTelefonos.Items.Add(listCliente.ElementAt(0).Lsc_telefono3);
                txtCorreoC.Text = listCliente.ElementAt(0).Lsc_correo;
                break;
            }

            //Tipo de producto - Consulto la cuenta en la tabla
            GridViewRow row = gvProductos.SelectedRow;
            //Consulto el tipo de producto seleccionado
            listProducto = LogRef.rf_tipo_producto("TP", row.Cells[3].Text);

            foreach (ReferidosInfo detalle in listProducto)
            {
                lblTipoProductoC.Text = detalle.Lsp_producto;
                break;
            }



        }

        // Obtiene Productos Clientes
        public void productos_clientes(string cli)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            List<ReferidosInfo> listCliente = new List<ReferidosInfo>();

            ddlProductos.Items.Clear();

            try
            {
                listCliente = LogRef.rf_datos_producto("LSP", cli);
                foreach (ReferidosInfo detalle in listCliente)
                {
                    //if (detalle.Lsc_telefono1.Trim().Equals(""))
                    //{
                    ddlProductos.Items.Add(detalle.Lsp_producto);
                    //}
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Validar")
            {
                ActualizarEstado();
                Response.Redirect("~/Referidos/DatosCallcenter.aspx");
            }

            if (e.CommandName == "Rechazar")
            {
                RechazaSolicitud();
                Response.Redirect("~/Referidos/DatosCallcenter.aspx");
            }
        }

        public void ActualizarEstado()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            string listInsertEstado = "";
            string listInsertLog = "";
            string estado = "AC";
            string id = "";
            string cuenta = "";
            string Observacion = "";

            try
            {
                if (gvProductos.SelectedRow != null)
                {
                    GridViewRow row = gvProductos.SelectedRow;
                    id = row.Cells[1].Text;
                    empleado = row.Cells[8].Text;
                    cliente = row.Cells[7].Text;
                    cuenta = row.Cells[3].Text;
                    Observacion = row.Cells[10].Text;
                }
                if (id != "")
                {
                    listInsertEstado = LogRef.rf_UpdateEstadoReg("UER", id, empleado, cuenta, estado);
                    listInsertLog = LogRef.rf_InsertLog("ILOG", idUsuario, empleado, cliente, "CALL1", "Verifica datos de cliente.");
                    DatosProductos();// Recarga Tabla
                    inicializa("Elementos");
                }
                else
                    lblMensaje.Text = "Seleccione un registro";

            }
            catch (Exception)
            {
                throw;
            }
        }

        public void RechazaSolicitud()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            string listInsertEstado = "";
            string listInsertLog = "";
            string estado = "";
            string id = "";
            string cuenta = "";
            string Observacion = "";
            try
            {
                if (gvProductos.SelectedRow != null)
                {
                    GridViewRow row = gvProductos.SelectedRow;
                    id = row.Cells[1].Text;
                    empleado = row.Cells[8].Text;
                    cliente = row.Cells[7].Text;
                    cuenta = row.Cells[3].Text;
                    Observacion = row.Cells[10].Text;
                }
                if (id != "")
                {
                    listInsertEstado = LogRef.rf_UpdateEstadoReg("URE", id, empleado, cuenta, estado);
                    listInsertLog = LogRef.rf_InsertLog("ILOG", idUsuario, empleado, cliente, "CALL2", "Rechaza solicitud");
                    DatosProductos();// Recarga Tabla
                    inicializa("Elementos");
                }
                else
                    lblMensaje.Text = "Seleccione un registro";

            }
            catch (Exception)
            {
                throw;
            }
        }
        


        private void ExportGridToExcel(string nombre)
        {
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename="+nombre +" "+ DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/" + nombre + " " + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + ".xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

            if (nombre == "ReportePendientes")
                gvGuardarPendientes.RenderControl(htmlWrite);
            else if (nombre == "ReporteRechazados")
                gvRechazadas.RenderControl(htmlWrite);

            Response.Write(stringWrite.ToString());
            Response.End();
            
        }
        
        protected void imgPendientes_Click(object sender, ImageClickEventArgs e)
        {
            ExportGridToExcel("ReportePendientes");
        }
        protected void imgRechazados_Click(object sender, ImageClickEventArgs e)
        {
            ExportGridToExcel("ReporteRechazados");
        }

        protected void ddlProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            List<ReferidosInfo> listCliente = new List<ReferidosInfo>();

            string producto;
            producto = ddlProductos.SelectedItem.Text;
            listCliente = LogRef.rf_tipo_producto("TP", producto);
            foreach (ReferidosInfo detalle in listCliente)
            {
                lblTipoProductoC.Text = detalle.Lsp_producto;
                break;
            }
        }
    }
}