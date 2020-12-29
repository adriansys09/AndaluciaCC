using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using INFO;
using LOGI;
using System.Web.Services.Description;

namespace ProyectoAndalucia.Referidos
{
    public partial class RegistroProducto : System.Web.UI.Page
    {
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
        //String menu = "REF7";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
                mostrarproductos();
                FnCargarCatalogos();
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
        public void mostrarproductos()
        {
            ReferidosLogi LogRef = new ReferidosLogi();
            ReferidosInfo InfRef = new ReferidosInfo();
            gvProdActivos.DataSource = LogRef.rf_puntos_colaborador("PC", ProyectoAndalucia.Inicio.IdUsuario);
            gvProdActivos.DataBind();
        }
        public void FnCargarCatalogos()
        {
            //busqueda de catalogos
            ReferidosLogi LogRef = new ReferidosLogi();
            DataTable CatProd = new DataTable();
            CatProd = LogRef.ConsultarCatalogo("ref_producto", "G", "", "", "");
            ddlProducto.DataSource = CatProd;
            ddlProducto.DataValueField = "codigo";
            ddlProducto.DataTextField = "valor";
            ddlProducto.DataBind();
        }
        public void FnCargarRegla(string tipo)
        {
            //busqueda de reglas 
            ReferidosLogi LogRef = new ReferidosLogi();
            DataTable regla = new DataTable();
            regla = LogRef.ConsultarReglaProd("S", tipo, "");
            ddlTipoAct.DataSource = regla;
            ddlTipoAct.DataValueField = "re_id";
            ddlTipoAct.DataTextField = "descripcion";
            ddlTipoAct.DataBind();
        }
        
        protected void gvProdActivos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // OCultar y mostrar columnas de datagrid
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Visible = true;
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Visible = true;
            }
        }

        protected void txtCedulaR_TextChanged(object sender, EventArgs e)
        {
            // accion de busqued de cliente de acuerdo al a cedula
            FnBuscarCliente(txtCedulaR.Text);
        }

        //protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //   //accion de busqueda de producto segun la regla
        //    string p_producto = ddlProducto.SelectedValue;
        //    FnCargarRegla(p_producto);
        //    txtCuenta.Focus();

        //}

        protected void txtApellidoE_TextChanged(object sender, EventArgs e)
        {
            //Accion de busqueda de empleado
            FnBuscarEmpleado(txtNombreE.Text.ToUpper() ,txtApellidoE.Text.ToUpper());
        }

        protected void btnRegistroProducto_Click(object sender, EventArgs e)
        {
            //Accion de boton registrar inforamcion de pantalla
            ReferidosLogi RefLog = new ReferidosLogi();
            List<RefPuntoColaboradorInfo > listaRef = new List<RefPuntoColaboradorInfo>();
            if (txtCedulaR.Text.Trim().Equals(""))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "La cuenta es obligatorio." + "');", true);
                txtCedulaR.Text = "";
                txtCedulaR.Focus();
            }
            else if (ddlProducto.SelectedValue.Trim().Equals(""))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "El producto es obligatorio." + "');", true);
                ddlProducto.SelectedIndex = 0;
            }
            else if (txtCuenta.Text.Trim().Equals(""))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "La cuenta es obligatorio." + "');", true);
                txtCuenta.Text = "";
                txtCuenta.Focus();
            }
            if (!txtCuenta.Text.Trim().Equals("") && !ddlProducto.SelectedValue.Trim().Equals("") && !txtCuenta.Text.Trim().Equals(""))
            {
                listaRef = RefLog.InsertarPuntosColaborador(LlenarPuntosColaborador());
                string listInsertLog = RefLog.rf_InsertLog("ILOG", idUsuario, lblNumEnteEmpl.Text.ToString(), lblNumEnteCli.Text.ToString(), "NEG1", "Registra producto");

                FnLimpiar();
                mostrarproductos();
            }
        }

        #region Funciones 
        public void FnBuscarCliente(string p_cedula )
        {
            //buscar el cliente en la tabla ente
            ReferidosLogi LogRef = new ReferidosLogi();
            List<RefClienteInfo> listaCliente = new List<RefClienteInfo>();
            ArrayList p_respuesta = null;

            p_respuesta = LogRef.ValidarIdentificacion(p_cedula);

            if (p_respuesta.Count == 0)
            {
                listaCliente = LogRef.ConsultarCliente("C", p_cedula.ToString());
                if (listaCliente.Count() > 0)
                {
                    foreach (RefClienteInfo datoRefCli in listaCliente)
                    {
                        
                            txtCedulaR.Text = datoRefCli.Ced_ruc;
                            txtNombre.Text = datoRefCli.Nombre.Trim().ToString();
                            txtMail.Text = datoRefCli.Correo;
                            txtTelefono.Text = datoRefCli.Telefono;
                            lblNumEnteCli.Text = datoRefCli.Ente.ToString();
                            //ddlProducto.SelectedValue = "N/A";
                    }
                }
                else
                {
                    lblMensajeE.Text = "No encontró datos.";
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + p_respuesta[1].ToString() + "');", true);
                txtCedulaR .Text = "";
                txtCedulaR .Focus();
            }
        }

        public void FnBuscarEmpleado(string p_nombre, string p_apellido)
        {
            //funcion buscar empleado ene la tabla ente 
            ReferidosLogi LogRef = new ReferidosLogi();
            List<RefClienteInfo> listaEmpleado = new List<RefClienteInfo>();

            listaEmpleado = LogRef.ConsultarEmpleado ("Q", "",p_nombre ,p_apellido );
            if (listaEmpleado.Count() > 0)
            {
                foreach (RefClienteInfo datoEmpl in listaEmpleado)
                {
                    lblNombreEmpl.Text = datoEmpl.Nombre;
                    lblNumEnteEmpl.Text = datoEmpl.Ente.ToString ();
                }
            }
            else
            {
                lblMensajeE.Text = "No encontró empleado.";
            }
        }

        private RefPuntoColaboradorInfo LlenarPuntosColaborador()
        {
            RefPuntoColaboradorInfo puntCol = new RefPuntoColaboradorInfo();
            puntCol.Pcid = 0;
            puntCol.Pcregla = int.Parse(0.ToString());
            puntCol.Pccuenta = txtCuenta.Text;
            puntCol.Pcreferido = int.Parse(lblNumEnteCli.Text.ToString());
            puntCol.Pcempleado = int.Parse(lblNumEnteEmpl.Text.ToString());
            puntCol.Pcoficial = ProyectoAndalucia.Inicio.IdUsuario;
            //puntCol.Pcpuntos = int.Parse(txtPuntos.Text.ToString());
            puntCol.Pcestado_puntos = "PEN";
            puntCol.Ppcconfirma = "";
            puntCol.Ppcobservacion = "";
            puntCol.Pcproducto = int.Parse(ddlProducto.SelectedValue.ToString());
            return puntCol;
        }

        private bool ValidarProducto ()
        {
            bool p_valida = false;
            DataTable p_resultado = new DataTable();
            ReferidosLogi logRef = new ReferidosLogi();
            p_resultado = logRef.ValidarExistenciaProducto("V",int.Parse (lblNumEnteCli.Text), int.Parse (ddlProducto.SelectedValue),txtCuenta.Text.ToUpper()  );
            if (p_resultado != null && p_resultado.Rows.Count >= 1 )
                p_valida = true;
            return p_valida;
        }

        private int ValidarDuplicado()
        {
            int p_valida = 0;
            DataTable p_dato = new DataTable();
            ReferidosLogi logRef = new ReferidosLogi();

            p_dato = logRef.ValidarExistenciaProducto("VD", int.Parse(lblNumEnteCli.Text), int.Parse(ddlProducto.SelectedValue), txtCuenta.Text.ToUpper());
            if (p_dato != null && p_dato.Rows.Count >= 1)
                p_valida = int.Parse(p_dato.Rows[0][0].ToString());

            return p_valida;
        }

        #endregion Funciones

        protected void txtCuenta_TextChanged(object sender, EventArgs e)
        {
            if (ValidarDuplicado() > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Cuenta " + txtCuenta.Text + " ya a registrada" + "');", true);
                txtCuenta.Text = "";
                txtCuenta.Focus();
            }
            else if (!ValidarProducto())
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Cuenta no válida." + "');", true);
                txtCuenta.Text = "";
                txtCuenta.Focus();
            }
        }

        #region Generales 
        private void FnLimpiar()
        {
            txtCedulaR.Text = "";
            txtNombre.Text = "";
            txtMail.Text = "";
            txtTelefono.Text = "";
            txtApellidoE.Text = "";
            txtNombreE.Text = "";
            txtCuenta.Text = "";
            lblNombreEmpl.Text = "";
            lblNumEnteCli.Text = "";
            lblNumEnteEmpl.Text = "";
            ddlProducto.SelectedIndex = 0;
        }
        #endregion Generales

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}