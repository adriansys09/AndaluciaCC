using DATA;
using INFO;
using LOGI;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Linq;
using Microsoft.Reporting.WinForms;
using Microsoft.Build.Tasks;
using System.IO;
using System.Web;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace ProyectoAndalucia.Cuadres
{
    public partial class CuadrePrincipal : System.Web.UI.Page
    {
        private static string Aplicacion = ConfigurationManager.AppSettings["NroAplicacion"];
        public static DataTable dt = new DataTable();//datatable de Oficina
        public static List<ClsOficinaInfo> ListaOficinas = new List<ClsOficinaInfo>();
        public static List<clsCuenta> ListaCuentas = new List<clsCuenta>();
        List<clsConsolidado> ListaConsolidado = new List<clsConsolidado>();
        List<clsCuadreCuenta> ListaCuadre = new List<clsCuadreCuenta>();
        public static clsResultado resultado = new clsResultado();
        public static clsFiltro filtroOficina = new clsFiltro();
        public static clsFiltro filtroPlazo = new clsFiltro();
        public static clsFiltro filtroCuenta = new clsFiltro();
        public static clsFiltro filtroConsolidado = new clsFiltro();
        public static clsFiltro filtroCuadre = new clsFiltro();
        public static Decimal TotalProd = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
                FnInicializar();
                FnCargarGrid();
                Fnmostrarproductos();
                fnCargarPaginacion();
                //fnCargarConsolidado();
                
            }
        }

        #region METODOS
        private void FnInicializar()
        {
            #region oficina 
                filtroOficina.Modo = 1;//modo para la consulta dinamica
                filtroOficina.Filas = 9999;//numero de filas que deben cargarse en el combo
                filtroOficina.Filtro = "ci_ciudad = of_ciudad ";
                filtroOficina.Orden = "";
                filtroOficina.Pagina = 1;
            #endregion
            #region Plazo Fijo
                filtroPlazo.Modo = 1;//modo para la consulta dinamica
                filtroPlazo.Filas = 10;//numero de filas que deben cargarse en el combo
                filtroPlazo.Filtro = "";
                filtroPlazo.Orden = "";
                filtroPlazo.Pagina = 1;
            #endregion
            #region Cosolidado
            filtroConsolidado.Modo = 1;//modo para la consulta dinamica
            filtroConsolidado.Filas = 10;//numero de filas que deben cargarse en el combo
            filtroConsolidado.Filtro = "";
            filtroConsolidado.Orden = "";
            filtroConsolidado.Pagina = 1;

            #endregion
            filtroCuadre.Modo = 1;//modo para la consulta dinamica
            filtroCuadre.Filas = 10;//numero de filas que deben cargarse en el combo
            filtroCuadre.Filtro = "";
            filtroCuadre.Orden = "";
            filtroCuadre.Pagina = 1;
        }

        private void fnCargarPaginacion()
        {
            //NumFilas = int.Parse(ConfigurationManager.AppSettings["NumFilas"]);
            string paginas = ConfigurationManager.AppSettings["paginas"];
            string[] LstPginas= paginas.Split(',');
            
            List<Int32> listado = new List<int>();
            for (int i=0; i < LstPginas.Length; i++) {
                listado.Add(Convert.ToInt32(LstPginas[i]));
            }

           
            ddFilasCC.DataSource = listado;
            ddFilasCC.DataBind();

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
                lblMensajeError.Visible = true;
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
                lblMensajeError.Visible = true;
                Response.Redirect("~/Inicio.aspx");
            }
        }
        public void FnCargarGrid()
        {
            bllCatalogo oficina = new bllCatalogo();
            //FuncionarioLogi oficina = new FuncionarioLogi();
            //clsFiltro filtroOficina = new clsFiltro();
            
            
            filtroOficina.p_login = Session["Login"].ToString();//"admin";

            filtroOficina.Usuario = Session["Login"].ToString();
            filtroOficina.Terminal = "";
            filtroOficina.Rol = Convert.ToInt64(Session["rol"]);
  

            try
            {
                ListaOficinas = oficina.OficinaConsultar(filtroOficina, out resultado);
                gvDatos.DataSource = ListaOficinas;
                gvDatos.DataBind();
            }
            catch (Exception ex) {
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
                
            }
        }
        public void Fnmostrarproductos()
        {
            FuncionarioLogi producto = new FuncionarioLogi();
            clsFiltro filtroProducto = new clsFiltro();

            List<clsProductoCobis> ListaProductos = new List<clsProductoCobis>();
            filtroProducto.Usuario = "admin";
            filtroProducto.Terminal = "";
            filtroProducto.Modo = 1;//modo para la consulta dinamica
            filtroProducto.Filas = 9999;//numero de filas que deben cargarse en el combo
            filtroProducto.Filtro = "pd_estado='V' and pd_producto in(4,7,14,19)";
            filtroProducto.Orden = "pd_producto";
            try
            {
                //se llena la lista que viene desde la base 
                ListaProductos = producto.ProductoConsultar(filtroProducto);
                ddlProducto.DataSource = ListaProductos;
                ddlProducto.DataValueField = "Producto";
                ddlProducto.DataTextField = "Descripcion";
                ddlProducto.DataBind();
                ddlProducto.Items.Insert(0, new ListItem("Todos", ""));
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
            }
        }
        //carga el grid que muestra los datos de los saldos por producto 
        private void fnCargarGirdConsolidado()
        {
            bllCuadre cuadre= new bllCuadre();

            filtroCuadre.Filtro = "";
            filtroCuadre.Filtro2 = "";
            filtroCuadre.Fecha = txtFecha.Text.Trim();
            String cuenta = "";
            try
            {
                if (chkConsolidado.Checked == true)
                {
                    List<clsCuadreCuenta> ListaCuadre1 = new List<clsCuadreCuenta>();
                    filtroCuadre.Modo = 3;
                    filtroCuadre.Filtro = "";
                    cuenta = txtCuenta.Text.Trim().Replace(".", "");
                    if (cuenta == "2105")
                    {
                        filtroCuadre.Modo = 4;
                    }
                    //consultar 2101
                    filtroCuadre.Filtro = "rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + cuenta + "%'";
                    ListaCuadre1 = cuadre.CuadreConsultar(filtroCuadre, out resultado);
                    if (resultado.Resultado != 0)
                    {
                        lblMensajeError.Text = resultado.Mensaje;
                        lblMensajeError.Visible = true;
                        return;
                    }
                    ListaCuadre = ListaCuadre1;
                    
                    gvDatosCuadre.DataSource = ListaCuadre;
                    gvDatosCuadre.DataBind();
                    
                    gvDatosCuadre.FooterRow.Cells[3].Text = "Totales:";
                    gvDatosCuadre.FooterRow.Cells[3].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;
                    //producto
                    gvDatosCuadre.FooterRow.Cells[4].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[4].HorizontalAlign = HorizontalAlign.Right;
                    gvDatosCuadre.FooterRow.Cells[4].Text = String.Format("{0:n2}", resultado.TotalProducto);
                    //conta
                    gvDatosCuadre.FooterRow.Cells[5].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                    gvDatosCuadre.FooterRow.Cells[5].Text = String.Format("{0:n2}", resultado.TotalCont);
                    //diferencias
                    gvDatosCuadre.FooterRow.Cells[6].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Right;
                    gvDatosCuadre.FooterRow.Cells[6].Text = String.Format("{0:n2}", resultado.TotalDif);
                    //nombre encabezado
                    gvDatosCuadre.Columns[4].HeaderText = "Saldo Consolidado";
                    //mostrar el gridview y su paginacion
                    dvCuadreCont.Visible = true;

                    lblPaginaCC.Text = filtroCuadre.Pagina.ToString();
                    lblPaginasCC.Text = resultado.TotalPaginas.ToString();
                    lblNropRegistrosCC.Text = resultado.TotalRegistros.ToString();
                    List<Int32> PaginasDiso = new List<int>();

                    for (int i = 0; i < resultado.TotalPaginas; i++)
                    {
                        PaginasDiso.Add(i + 1);
                    }
                    ddlPaginasCC.DataSource = PaginasDiso;
                    ddlPaginasCC.DataBind();
                    ddlPaginasCC.SelectedValue = filtroCuadre.Pagina.ToString();
                    if (ddlPaginasCC.SelectedValue == lblPaginasCC.Text)
                        lbnNextCC.Enabled = false;
                    else
                        lbnNextCC.Enabled = true;

                    if (ddlPaginasCC.SelectedValue == "1")
                        lbnPrevCC.Enabled = false;
                    else
                        lbnPrevCC.Enabled = true;
                }
                else
                {
                    //CONSULTA NO CONSOLIDADA
                    filtroCuadre.Modo = 1;
                    List<clsCuadreCuenta> listaCtas = new List<clsCuadreCuenta>();
                    List<clsCuadreCuenta> listaCtas2105 = new List<clsCuadreCuenta>();
                    if (ddlProducto.SelectedValue == "4")
                    {
                        if (ddlCuenta.SelectedValue == "")
                        {
                            //filtroCuadre.Modo = 5;
                            filtroCuadre.Filtro = "rf_fecha_carga='"+ txtFecha.Text.Trim() + "' and (rf_cuenta like '210135%' OR rf_cuenta like '210150%') ";
                            //filtroCuadre.Filtro2= " rf_cuenta like '2105%' and rf_prod_cobis = 4";
                        }
                        else if (ddlCuenta.SelectedValue.Trim() == "2105") {
                            filtroCuadre.Modo = 2;
                            filtroCuadre.Filtro = "rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '2105%' and rf_prod_cobis = 4";
                        }
                        else
                            filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                    }
                    //PLAZO FIJO
                    if (ddlProducto.SelectedValue == "14")
                    {
                        filtroCuadre.Modo = 1;
                        if (ddlCuenta.SelectedValue == "")
                        {
                            //filtroCuadre.Modo = 5;
                            filtroCuadre.Filtro = "rf_fecha_carga='" + txtFecha.Text.Trim() + "' and  (rf_cuenta like '2103%' or  rf_cuenta like '210140%')";
                            //filtroCuadre.Filtro2 = " rf_cuenta like '2105%' and rf_prod_cobis = 140";
                        }
                        else if (ddlCuenta.SelectedValue.Trim() == "2105")
                        {
                            filtroCuadre.Modo = 2;
                            filtroCuadre.Filtro = "rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                        }
                        else
                            filtroCuadre.Filtro = "rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                    }

                    if (txtCodigoOficina.Text != "")
                    {
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cod_oficina=" + Convert.ToInt32(txtCodigoOficina.Text)+" AND ("+ filtroCuadre.Filtro+")";
                        if (filtroCuadre.Filtro2!="")
                            filtroCuadre.Filtro2 = " rf_cod_oficina=" + Convert.ToInt32(txtCodigoOficina.Text) + " AND (" + filtroCuadre.Filtro2 + ")"; 

                    }


                    ListaCuadre = cuadre.CuadreConsultar(filtroCuadre, out resultado);
                    //identifica si existe un error en el servidor y lo muesta en pantalla.
                    if (resultado.Resultado != 0)
                    {
                        lblMensajeError.Text = resultado.Mensaje;
                        lblMensajeError.Visible = true;
                        return;
                    }

                    gvDatosCuadre.DataSource = ListaCuadre;
                    gvDatosCuadre.DataBind();

                    
                    //nombre encabezado
                   

                    //pie del gridview
                    gvDatosCuadre.FooterRow.Cells[3].Text="Totales:";
                    gvDatosCuadre.FooterRow.Cells[3].Font.Bold=true;
                    gvDatosCuadre.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;
                    //producto
                    gvDatosCuadre.FooterRow.Cells[4].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[4].HorizontalAlign = HorizontalAlign.Right;
                    gvDatosCuadre.FooterRow.Cells[4].Text = String.Format("{0:n2}", resultado.TotalProducto);
                    //conta
                    gvDatosCuadre.FooterRow.Cells[5].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                    gvDatosCuadre.FooterRow.Cells[5].Text = String.Format("{0:n2}", resultado.TotalCont);
                    //diferencias
                    gvDatosCuadre.FooterRow.Cells[6].Font.Bold = true;
                    gvDatosCuadre.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Right;
                    gvDatosCuadre.FooterRow.Cells[6].Text = String.Format("{0:n2}", resultado.TotalDif);

                    
                    //mostrar el gridview y su paginacion
                    dvCuadreCont.Visible = true;

                    lblPaginaCC.Text = filtroCuadre.Pagina.ToString();
                    lblPaginasCC.Text = resultado.TotalPaginas.ToString();
                    lblNropRegistrosCC.Text = resultado.TotalRegistros.ToString();
                    List<Int32> PaginasDiso = new List<int>();

                    for (int i = 0; i < resultado.TotalPaginas; i++)
                    {
                        PaginasDiso.Add(i + 1);
                    }
                    ddlPaginasCC.DataSource = PaginasDiso;
                    ddlPaginasCC.DataBind();
                    ddlPaginasCC.SelectedValue = filtroCuadre.Pagina.ToString();
                    if (ddlPaginasCC.SelectedValue == lblPaginasCC.Text)
                        lbnNextCC.Enabled = false;
                    else
                        lbnNextCC.Enabled = true;

                    if (ddlPaginasCC.SelectedValue == "1")
                        lbnPrevCC.Enabled = false;
                    else
                        lbnPrevCC.Enabled = true;
                }
                if (ListaCuadre.Count > 0)
                {
                    btnExcel.Visible = true;
                    notificacionCorreo.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
                // throw new Exception(ex.Message);
            }
        }

        protected void fnLimpiarError()
        {
            lblMensajeError.Visible = false;
            lblMensajeError.Text = "";
            lblMensajeExito.Visible = false;
            lblMensajeExito.Text = "";
        }
        /// <summary>
        /// CARGA EL COMBO DE CUENTAS
        /// </summary>
        private void fnCargarConsolidado()
        {
            
            filtroCuenta.Usuario = "admin";
            filtroCuenta.Terminal = "";
            filtroCuenta.Modo = 1;//modo para la consulta dinamica
            filtroCuenta.Filas = 9999;//numero de filas que deben cargarse en el combo
            filtroCuenta.Orden = "";
            //ahorro
            if (ddlProducto.SelectedValue == "4")
            {
                //filtroCuenta.Filtro = "cu_estado='V' and cu_empresa=1 and (cu_cuenta like '210135%' or cu_cuenta like '%210140%' or cu_cuenta like '%210150%'  )";
                filtroCuenta.Filtro = "cu_estado='V' and cu_empresa=1 and cu_cuenta in( '210135' ,'210150')";
            }
            if (ddlProducto.SelectedValue == "7")
            {
                filtroCuenta.Filtro = "cu_estado='V' and cu_empresa=1  and cu_cuenta like '14%' ";// or cu_cuenta like '210140%' or cu_cuenta like '210150%'  )"; 
             }
            //plazo fijo
            if (ddlProducto.SelectedValue == "14") {
                filtroCuenta.Filtro = "cu_estado='V' and cu_empresa=1 and cu_cuenta in('2103','210140') ";
            }
            
            //
            if (ddlProducto.SelectedValue == "19")
            {
                filtroCuenta.Filtro = "cu_estado='V' and cu_empresa=1 ";//and (cu_cuenta like '210135%' or cu_cuenta like '210140%' or cu_cuenta like '210150%'  )";
            }

            
            if (ddlProducto.SelectedValue == "")
            {
                ddlCuenta.Items.Clear();
                ddlCuenta.Items.Insert(0, new ListItem("Todos", ""));
                
            }
            else
            {
                ddlCuenta.Items.Clear();
                //ddlCuenta.Items.Insert(0, new ListItem("Todos", ""));
                bllCatalogo cuentasCobis = new bllCatalogo();
                ListaCuentas = cuentasCobis.CuentaConsultar(filtroCuenta, out resultado);
                ddlCuenta.DataSource = ListaCuentas;
                ddlCuenta.DataValueField = "Cuenta";
                ddlCuenta.DataTextField = "CuentaDes";
                ddlCuenta.DataBind();
                ddlCuenta.Items.Insert(0, new ListItem("Todos", ""));
            }

        }
        #endregion

        #region GRIDS
        protected void gvDatos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDatos.PageIndex = e.NewPageIndex;
            FnCargarGrid();
        }
        // se ejecuta cuando se hace click en el icono de seleccionar en la pantalla de oficinas
        protected void gvDatos_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            fnLimpiarError();
            txtCodigoOficina.Text = gvDatos.Rows[e.NewSelectedIndex].Cells[1].Text;
            lblNombreOficina.Text = gvDatos.Rows[e.NewSelectedIndex].Cells[2].Text;
            if (txtCodigoOficina.Text != "")
            {
                chkConsolidado.Visible = false;
            }
            btnShowModal.Visible = false;
            btnLimpiarOficina.Visible = true;
        }

        protected void gvDatos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var resultado = int.Parse(gvDatos.Rows[e.NewEditIndex].Cells[1].Text);
        }
        protected void gvDatos_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        #endregion

        #region BOTONES
        protected void btnShowModal_Click(object sender, EventArgs e)
        {
            
        }
        protected void btnLimpiarOficina_Click(object sender, EventArgs e)
        {
            txtCodigoOficina.Text = "";
            lblNombreOficina.Text = "";
            btnShowModal.Visible = true;
            btnLimpiarOficina.Visible = false;
            lblMensajeError.Visible = true;
            lblMensajeError.Text = "";
            chkConsolidado.Visible = true;
            fnLimpiarGrid();
        }
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Inicio.aspx");
        }

        protected void bntLimpiar_Click(object sender, EventArgs e)
        {
            fnLimpiarError();
            txtCodigoOficina.Text = "";
            lblNombreOficina.Text = "";
            lblCuentaDes.Text = "";
            txtFecha.Text = "";
            fnLimpiarGrid();   
            dt.Clear();
            ddlProducto.SelectedValue="";
            ddlCuenta.Items.Clear();
            ddlCuenta.Items.Insert(0, new ListItem("Todos", ""));
            chkConsolidado.Checked = false;
            txtCorreos.Text = "";
            chkConsolidado_CheckedChanged(null, null);
        }

        private void fnLimpiarGrid()
        {
            gvDatosCuadre.DataSource = null;
            gvDatosCuadre.DataBind();
            dvCuadreCont.Visible = false;
        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            fnLimpiarError();
            if (txtFecha.Text == "")
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Debe ingresar la Fecha";
                txtFecha.Focus();
                return;
            }
            
            if (ddlProducto.SelectedValue == "" && chkConsolidado.Checked==false)
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Debe seleccionar Producto";
                ddlProducto.Focus();
                return;
            }
            if (chkConsolidado.Checked == true && txtCuenta.Text=="") {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Debe ingresar la cuenta";
                ddlProducto.Focus();
                return;
            }

                //llenado de grid
                fnCargarGirdConsolidado();          
        }
        #endregion

        #region OBJETOS VARIOS TEXTBOX Y COMBOS
        protected void txtCodigoOficina_TextChanged(object sender, EventArgs e)
        {
            fnLimpiarError();
            fnLimpiarGrid();
            if (txtCodigoOficina.Text==""){
                lblNombreOficina.Text = "";
                btnShowModal.Visible = true;
                btnLimpiarOficina.Visible = false;

                lblMensajeError.Visible = true;
                lblMensajeError.Text = "";
                chkConsolidado.Visible = true;
                return;
            }
            if (txtCodigoOficina.Text != "") {
                chkConsolidado.Visible = false;
            }

            for (int i=0;i< ListaOficinas.Count;i++)
            {

                if (ListaOficinas[i].Oficina == Convert.ToInt32(txtCodigoOficina.Text))
                {
                    lblNombreOficina.Text = ListaOficinas[i].Nombre;
                    btnShowModal.Visible = false;
                    btnLimpiarOficina.Visible = true;
                    break;
                }
                else
                {
                    //txtCodigoOficina.Text = "";
                    lblNombreOficina.Text = "";
                    btnShowModal.Visible = true;
                    btnLimpiarOficina.Visible = false;
                }
            }
        }

       
        protected void txtFecha_TextChanged(object sender, EventArgs e)
        {
            fnLimpiarError();
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            fnLimpiarError();
            fnLimpiarGrid();
            fnCargarConsolidado();

        }

        protected void ddlPaginacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            //filtroOficina.Filas=Convert.ToInt32(ddlPaginacion.SelectedValue);
            //FnCargarGrid();
        }

        protected void ddlPaginacionCuadre_SelectedIndexChanged(object sender, EventArgs e)
        {
            //filtroPlazo.Filas = Convert.ToInt32(ddlPaginacionCuadre.SelectedValue);
           // fnCargarGirdConsolidado();
        }
        #endregion

        protected void ddlPaginacionCuadre_TextChanged(object sender, EventArgs e)
        {
           // filtroPlazo.Filas = Convert.ToInt32(ddlPaginacionCuadre.SelectedValue);
            //fnCargarGirdConsolidado();
        }

        protected void btnPrevio_Click(object sender, EventArgs e)
        {

        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// cambio de producto
        /// </summary>
        protected void chkConsolidado_CheckedChanged(object sender, EventArgs e)
        {
            fnLimpiarGrid();
            lblCuentaDes.Text = "";
            notificacionCorreo.Visible = false;
            if (chkConsolidado.Checked)
            {
                txtCodigoOficina.Enabled = false;
                txtCodigoOficina.Text = "255";
                rowOficina.Visible= false;
                divCuentaddl.Visible = false;
                divProductoddl.Visible = false;
                divCuentatxt.Visible = true;
                
            }
            else
            {
                txtCodigoOficina.Enabled = true;
                txtCodigoOficina.Text = "";
                rowOficina.Visible= true;
                divCuentaddl.Visible = true;
                divProductoddl.Visible = true;
                divCuentatxt.Visible = false;
            }
        }

        protected void ddlCuenta_SelectedIndexChanged(object sender, EventArgs e)
        {
            fnLimpiarGrid();
        }

        protected void ddlPaginaCons_SelectedIndexChanged(object sender, EventArgs e)
        {
            //filtroConsolidado.Filas = Convert.ToInt32(ddlPaginaCons.SelectedValue);
            //filtroConsolidado.Pagina = Convert.ToInt32(ddlPaginasCons.SelectedValue);
            //fnCargarGirdConsolidado();
        }

        protected void ddlPaginasCons_SelectedIndexChanged(object sender, EventArgs e)
        {
            //filtroConsolidado.Filas = Convert.ToInt32(ddlPaginasCons.SelectedValue); 
        }

        protected void btnConSig_Click(object sender, EventArgs e)
        {
            //filtroConsolidado.Filas = Convert.ToInt32(ddlPaginaCons.SelectedValue);
            //filtroConsolidado.Pagina = Convert.ToInt32(ddlPaginasCons.SelectedValue)+1;
            //fnCargarGirdConsolidado();
        }

        protected void btnConPrev_Click(object sender, EventArgs e)
        {
            //filtroConsolidado.Filas = Convert.ToInt32(ddlPaginaCons.SelectedValue);
            //filtroConsolidado.Pagina = Convert.ToInt32(ddlPaginasCons.SelectedValue) - 1;
            //fnCargarGirdConsolidado();
        }

        protected void ddFilasCC_SelectedIndexChanged(object sender, EventArgs e)
        {
            filtroCuadre.Filas= Convert.ToInt32(ddFilasCC.SelectedValue);
            filtroCuadre.Pagina = Convert.ToInt32(ddlPaginasCC.SelectedValue);
            fnCargarGirdConsolidado();
        }

        protected void ddlPaginasCC_SelectedIndexChanged(object sender, EventArgs e)
        {
            filtroCuadre.Pagina = Convert.ToInt32(ddlPaginasCC.SelectedValue);
            fnCargarGirdConsolidado();
        }

        protected void lbnPrevCC_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt32(ddlPaginasCC.SelectedValue) - 1 > 0) 
            {
                filtroCuadre.Filas = Convert.ToInt32(ddFilasCC.SelectedValue);
                filtroCuadre.Pagina = Convert.ToInt32(ddlPaginasCC.SelectedValue) - 1;

                fnCargarGirdConsolidado(); 
            }
        }

        protected void lbnNextCC_Click(object sender, EventArgs e)
        {
            if ((Convert.ToInt32(ddlPaginasCC.SelectedValue) + 1) <= Convert.ToInt32(lblPaginasCC.Text))
            {
                filtroCuadre.Filas = Convert.ToInt32(ddFilasCC.SelectedValue);
                filtroCuadre.Pagina = Convert.ToInt32(ddlPaginasCC.SelectedValue) + 1;
                fnCargarGirdConsolidado();
            }
        }

        protected void gvDatosCuadre_RowDataBound(object sender, GridViewRowEventArgs e)
        {


            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (ddlProducto.SelectedValue.Trim() == "4")
                    e.Row.Cells[4].Text  = "Saldo Ahorros";
                if (ddlProducto.SelectedValue.Trim() == "14")
                    e.Row.Cells[4].Text = "Saldo Plazo Fijo";
                
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Decimal diferencia = Convert.ToDecimal(e.Row.Cells[6].Text);
                if (diferencia != 0)
                {
                    e.Row.BackColor = Color.Red;
                }
            }
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            
            bllCuadre cuadre = new bllCuadre();

            #region Datos   
            string cuenta = "";
            filtroCuadre.Filtro = "";
            filtroCuadre.Filas = Convert.ToInt32(lblNropRegistrosCC.Text);
            //lblPaginasCC.Text = resultado.TotalPaginas.ToString();
             
            filtroCuadre.Fecha = txtFecha.Text.Trim();
            if (chkConsolidado.Checked == true)
            {
                List<clsCuadreCuenta> ListaCuadre1 = new List<clsCuadreCuenta>();
                filtroCuadre.Modo = 3;
                filtroCuadre.Filtro = "";
                cuenta = txtCuenta.Text.Trim().Replace(".", "");
                if (cuenta == "2105")
                {
                    filtroCuadre.Modo = 4;
                }
                //consultar 2101
                filtroCuadre.Filtro = " rf_cuenta like '" + cuenta + "%'";
                ListaCuadre1 = cuadre.CuadreConsultar(filtroCuadre, out resultado);
                if (resultado.Resultado != 0)
                {
                    lblMensajeError.Text = resultado.Mensaje;
                    lblMensajeError.Visible = true;
                    return;
                }
                ListaCuadre = ListaCuadre1;

            }
            else
            {
                //CONSULTA NO CONSOLIDADA
                filtroCuadre.Modo = 1;
                List<clsCuadreCuenta> listaCtas = new List<clsCuadreCuenta>();
                List<clsCuadreCuenta> listaCtas2105 = new List<clsCuadreCuenta>();
                if (ddlProducto.SelectedValue == "4")
                {
                    if (ddlCuenta.SelectedValue == "")
                    {
                        //filtroCuadre.Modo = 5;
                        filtroCuadre.Filtro = " rf_cuenta like '210135%' OR rf_cuenta like '210150%' ";
                        //filtroCuadre.Filtro2= " rf_cuenta like '2105%' and rf_prod_cobis = 4";
                    }
                    else if (ddlCuenta.SelectedValue.Trim() == "2105")
                    {
                        filtroCuadre.Modo = 2;
                        filtroCuadre.Filtro = " rf_cuenta like '2105%' and rf_prod_cobis = 4";
                    }
                    else
                        filtroCuadre.Filtro = " rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                }
                //PLAZO FIJO
                if (ddlProducto.SelectedValue == "14")
                {
                    filtroCuadre.Modo = 1;
                    if (ddlCuenta.SelectedValue == "")
                    {
                        //filtroCuadre.Modo = 5;
                        filtroCuadre.Filtro = " rf_cuenta like '2103%' or  rf_cuenta like '210140%'";
                        //filtroCuadre.Filtro2 = " rf_cuenta like '2105%' and rf_prod_cobis = 140";
                    }
                    else if (ddlCuenta.SelectedValue.Trim() == "2105")
                    {
                        filtroCuadre.Modo = 2;
                        filtroCuadre.Filtro = " rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                    }
                    else
                        filtroCuadre.Filtro = " rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                }

                if (txtCodigoOficina.Text != "")
                {
                    filtroCuadre.Filtro = " rf_cod_oficina=" + Convert.ToInt32(txtCodigoOficina.Text) + " AND (" + filtroCuadre.Filtro + ")";
                    if (filtroCuadre.Filtro2 != "")
                        filtroCuadre.Filtro2 = " rf_cod_oficina=" + Convert.ToInt32(txtCodigoOficina.Text) + " AND (" + filtroCuadre.Filtro2 + ")";

                }


                ListaCuadre = cuadre.CuadreConsultar(filtroCuadre, out resultado);
                //identifica si existe un error en el servidor y lo muesta en pantalla.
                if (resultado.Resultado != 0)
                {
                    lblMensajeError.Text = resultado.Mensaje;
                    lblMensajeError.Visible = true;
                    return;
                }

            }
            try
            {
                DataSet ds1 = new DataSet();
                DataTable tabla = new DataTable("0");


                //ListaCuadre = cuadre.CuadreConsultar(filtroCuadre, out resultado);

                tabla.Columns.Add("IdRegistros");
                tabla.Columns.Add("Oficina");
                tabla.Columns.Add("NombreOficina");
                tabla.Columns.Add("Cuenta");
                tabla.Columns.Add("CuentaDes");
                tabla.Columns.Add("SaldoConsolidado");
                tabla.Columns.Add("SaldoTotContable");
                tabla.Columns.Add("Diferencia");

                foreach (clsCuadreCuenta cuad in ListaCuadre)
                {
                    DataRow row = tabla.NewRow();
                    row["IdRegistros"] = cuad.IdRegistros;
                    row["Oficina"] = cuad.Oficina;
                    row["NombreOficina"] = cuad.NombreOficina;
                    row["Cuenta"] = cuad.Cuenta;
                    row["CuentaDes"] = cuad.CuentaDes;
                    row["SaldoConsolidado"] = cuad.SaldoConsolidado;
                    row["SaldoTotContable"] = cuad.SaldoTotContable;
                    row["Diferencia"] = cuad.Diferencia;
                    tabla.Rows.Add(row);
                }
                ds1.Tables.Add(tabla);

                //identifica si existe un error en el servidor y lo muesta en pantalla.
                if (resultado.Resultado != 0)
                {
                    lblMensajeError.Text = resultado.Mensaje;
                    lblMensajeError.Visible = true;
                }
                //CARGA DATOS PARA EL REPORTE
                var tableEmpresa = new DataTable("1");
                tableEmpresa.Columns.Add("PA_FECHA_CORTE");
                tableEmpresa.Columns.Add("PA_OFICINA");
                tableEmpresa.Columns.Add("PA_PRODUCTO");
                tableEmpresa.Columns.Add("PA_CUENTA");

                ds1.Tables.Add(tableEmpresa);

                var headRow = ds1.Tables[1].NewRow();
                headRow[0] = txtFecha.Text;//1
                headRow[1] = lblNombreOficina.Text;//Ambiente:1 PRUEBAS,2:PRODUCCION
                headRow[2] = ddlProducto.SelectedItem;//emision parametro general
                headRow[3] = ddlCuenta.SelectedItem;
                tableEmpresa.Rows.Add(headRow);
                Microsoft.Reporting.WebForms.ReportDataSource reportDataSourse = new Microsoft.Reporting.WebForms.ReportDataSource("DsCuadre", ds1.Tables[0]);
                Microsoft.Reporting.WebForms.ReportDataSource reportDataSourse1 = new Microsoft.Reporting.WebForms.ReportDataSource("DsParametros", ds1.Tables[1]);



                Microsoft.Reporting.WebForms.LocalReport localReport = new Microsoft.Reporting.WebForms.LocalReport();
                localReport.ReportPath = "Reportes/CuadreContable.rdlc";
                localReport.EnableExternalImages = true;

                localReport.DataSources.Add(reportDataSourse);
                localReport.DataSources.Add(reportDataSourse1);

                string reportType = "PDF";
                string mimeType;
                string encoding;
                string fileNameExtension;

                string deviceInfo =
                                            "<DeviceInfo>" +
                                            "  <OutputFormat>EMF</OutputFormat>" +
                                            "  <PageWidth>8.3in</PageWidth>" +
                                            "  <PageHeight>11.7in</PageHeight>" +
                                            "  <MarginTop>0in</MarginTop>" +
                                            "  <MarginLeft>0in</MarginLeft>" +
                                            "  <MarginRight>0in</MarginRight>" +
                                            "  <MarginBottom>0in</MarginBottom>" +
                                            "</DeviceInfo>";

                Microsoft.Reporting.WebForms.Warning[] warnings;
                string[] streams;
                byte[] renderedBytes;

                //Render the report
                renderedBytes = localReport.Render("EXCELOPENXML", null, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);

                string pathtMP = HttpContext.Current.Request.PhysicalApplicationPath + "/tempreports/";
            
                FileStream fs = new FileStream(pathtMP+ "cuadreContable.xls",
                FileMode.Create);
                fs.Write(renderedBytes, 0, renderedBytes.Length);
                fs.Close();
               
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("content-disposition", "attachment;filename=" + pathtMP + "cuadreContable.xls");
                Response.TransmitFile(pathtMP + "cuadreContable.xls");
                Response.Flush();


                Response.End();
            
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
            
            }
            #endregion
        }

        protected void txtCuenta_TextChanged(object sender, EventArgs e)
        {
            lblCuentaDes.Text = "";
            fnLimpiarError();
            fnLimpiarGrid();
            bllCatalogo cuentasCobis = new bllCatalogo();
            filtroCuenta.Usuario = "admin";
            filtroCuenta.Terminal = "";
            filtroCuenta.Modo = 1;//modo para la consulta dinamica
            filtroCuenta.Filas = 9999;//numero de filas que deben cargarse en el combo
            filtroCuenta.Orden = "";
            filtroCuenta.Filtro = "";
            List<clsCuenta> ListaCtaCont = cuentasCobis.CuentaConsultar(filtroCuenta, out resultado);
            string cuenta = txtCuenta.Text.Replace(".", "");
            for (int i = 0; i < ListaCtaCont.Count; i++) {
                if (cuenta == ListaCtaCont[i].Cuenta.Trim()) {
                    lblCuentaDes.Text = ListaCtaCont[i].CuentaDes;
                    break;
                }
            }

        }

        ///metodo para bajar archivo al pc del cliente.
        private void ButtonDescargar_click()
        {
            try
            {
                //Response.Clear();
                //Response.ContentType = "application/octet-stream";
                //Response.AppendHeader("content-disposition", "attachment;filename=" + filePath);
                //Response.TransmitFile(filePath);
                //Response.Flush();


                //Response.TransmitFile(Server.MapPath("~/tempreports/cuadreContable.xls"));

                ////Response.End();
                //Response.End();
            }
            catch (Exception ex)
            {
                // Trap the error, if any.
                // System.Web.HttpContext.Current.Response.Write("Error : " + ex.Message);
                //fnShowError(ctrError, ex);
            }
        }
        /// <summary>
        /// VALIDA QUE LOS CORREOS SEAN VALIDOS
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        private Boolean email_bien_escrito(String email)
        {
            String expresion;
            expresion = "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
            if (Regex.IsMatch(email, expresion))
            {
                if (Regex.Replace(email, expresion, String.Empty).Length == 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        protected void btnEnvioNotificacion_Click(object sender, EventArgs e)
        {
            fnLimpiarError();
            fnMensajeError("", true);
            if (txtCorreos.Text == "")
            {
                fnMensajeError("Ingrese correo válido.", true);
                return;
            }

            String[] correos = txtCorreos.Text.Split(';');
            List<string> correosDestino = new List<string>();

            for (int i = 0; i < correos.Length; i++)
            {
                var resultado = email_bien_escrito(correos[i]);
                if (resultado == false)
                {
                    fnMensajeError("Correo " + correos[i] + " no válido", true);
                    return;
                }
            }

            correosDestino = correos.ToList();

            bllCuadre cuadre = new bllCuadre();


            string cuenta = "";
            filtroCuadre.Filtro = "";
            filtroCuadre.Filas = Convert.ToInt32(lblNropRegistrosCC.Text);
            //lblPaginasCC.Text = resultado.TotalPaginas.ToString();

            filtroCuadre.Fecha = txtFecha.Text.Trim();
            if (chkConsolidado.Checked == true)
            {
                List<clsCuadreCuenta> ListaCuadre1 = new List<clsCuadreCuenta>();
                filtroCuadre.Modo = 3;
                filtroCuadre.Filtro = "";
                cuenta = txtCuenta.Text.Trim().Replace(".", "");
                if (cuenta == "2105")
                {
                    filtroCuadre.Modo = 4;
                }
                //consultar 2101
                filtroCuadre.Filtro = " rf_cuenta like '" + cuenta + "%'";
                ListaCuadre1 = cuadre.CuadreConsultar(filtroCuadre, out resultado);
                if (resultado.Resultado != 0)
                {
                    lblMensajeError.Text = resultado.Mensaje;
                    lblMensajeError.Visible = true;
                    return;
                }
                ListaCuadre = ListaCuadre1;

            }
            else
            {
                //CONSULTA NO CONSOLIDADA
                filtroCuadre.Modo = 1;
                List<clsCuadreCuenta> listaCtas = new List<clsCuadreCuenta>();
                List<clsCuadreCuenta> listaCtas2105 = new List<clsCuadreCuenta>();
                if (ddlProducto.SelectedValue == "4")
                {
                    if (ddlCuenta.SelectedValue == "")
                    {
                        //filtroCuadre.Modo = 5;
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '210135%' OR rf_cuenta like '210150%' ";
                        //filtroCuadre.Filtro2= " rf_cuenta like '2105%' and rf_prod_cobis = 4";
                    }
                    else if (ddlCuenta.SelectedValue.Trim() == "2105")
                    {
                        filtroCuadre.Modo = 2;
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '2105%' and rf_prod_cobis = 4";
                    }
                    else
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                }
                //PLAZO FIJO
                if (ddlProducto.SelectedValue == "14")
                {
                    filtroCuadre.Modo = 1;
                    if (ddlCuenta.SelectedValue == "")
                    {
                        //filtroCuadre.Modo = 5;
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '2103%' or  rf_cuenta like '210140%'";
                        //filtroCuadre.Filtro2 = " rf_cuenta like '2105%' and rf_prod_cobis = 140";
                    }
                    else if (ddlCuenta.SelectedValue.Trim() == "2105")
                    {
                        filtroCuadre.Modo = 2;
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                    }
                    else
                        filtroCuadre.Filtro = " rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cuenta like '" + ddlCuenta.SelectedValue.Trim() + "%'";
                }

                if (txtCodigoOficina.Text != "")
                {
                    filtroCuadre.Filtro = " rf_cod_oficina=" + Convert.ToInt32(txtCodigoOficina.Text) + " AND (" + filtroCuadre.Filtro + ")";
                    if (filtroCuadre.Filtro2 != "")
                        filtroCuadre.Filtro2 = "rf_fecha_carga='" + txtFecha.Text.Trim() + "' and rf_cod_oficina=" + Convert.ToInt32(txtCodigoOficina.Text) + " AND (" + filtroCuadre.Filtro2 + ")";

                }


                ListaCuadre = cuadre.CuadreConsultar(filtroCuadre, out resultado);
                //identifica si existe un error en el servidor y lo muesta en pantalla.
                if (resultado.Resultado != 0)
                {
                    lblMensajeError.Text = resultado.Mensaje;
                    lblMensajeError.Visible = true;
                    return;
                }

            }

                DataSet ds1 = new DataSet();
                DataTable tabla = new DataTable("0");


                //ListaCuadre = cuadre.CuadreConsultar(filtroCuadre, out resultado);

                tabla.Columns.Add("IdRegistros");
                tabla.Columns.Add("Oficina");
                tabla.Columns.Add("NombreOficina");
                tabla.Columns.Add("Cuenta");
                tabla.Columns.Add("CuentaDes");
                tabla.Columns.Add("SaldoConsolidado");
                tabla.Columns.Add("SaldoTotContable");
                tabla.Columns.Add("Diferencia");

                foreach (clsCuadreCuenta cuad in ListaCuadre)
                {
                    DataRow row = tabla.NewRow();
                    row["IdRegistros"] = cuad.IdRegistros;
                    row["Oficina"] = cuad.Oficina;
                    row["NombreOficina"] = cuad.NombreOficina;
                    row["Cuenta"] = cuad.Cuenta;
                    row["CuentaDes"] = cuad.CuentaDes;
                    row["SaldoConsolidado"] = cuad.SaldoConsolidado;
                    row["SaldoTotContable"] = cuad.SaldoTotContable;
                    row["Diferencia"] = cuad.Diferencia;
                    tabla.Rows.Add(row);
                }
                ds1.Tables.Add(tabla);

                //identifica si existe un error en el servidor y lo muesta en pantalla.
                if (resultado.Resultado != 0)
                {
                    lblMensajeError.Text = resultado.Mensaje;
                    lblMensajeError.Visible = true;
                }
                //CARGA DATOS PARA EL REPORTE
                var tableEmpresa = new DataTable("1");
                tableEmpresa.Columns.Add("PA_FECHA_CORTE");
                tableEmpresa.Columns.Add("PA_OFICINA");
                tableEmpresa.Columns.Add("PA_PRODUCTO");
                tableEmpresa.Columns.Add("PA_CUENTA");

                ds1.Tables.Add(tableEmpresa);

                var headRow = ds1.Tables[1].NewRow();
                headRow[0] = txtFecha.Text;//1
                headRow[1] = lblNombreOficina.Text;//Ambiente:1 PRUEBAS,2:PRODUCCION
                headRow[2] = ddlProducto.SelectedItem;//emision parametro general
                headRow[3] = ddlCuenta.SelectedItem;
                tableEmpresa.Rows.Add(headRow);
                Microsoft.Reporting.WebForms.ReportDataSource reportDataSourse = new Microsoft.Reporting.WebForms.ReportDataSource("DsCuadre", ds1.Tables[0]);
                Microsoft.Reporting.WebForms.ReportDataSource reportDataSourse1 = new Microsoft.Reporting.WebForms.ReportDataSource("DsParametros", ds1.Tables[1]);



                Microsoft.Reporting.WebForms.LocalReport localReport = new Microsoft.Reporting.WebForms.LocalReport();
                localReport.ReportPath = "Reportes/CuadreContable.rdlc";
                localReport.EnableExternalImages = true;

                localReport.DataSources.Add(reportDataSourse);
                localReport.DataSources.Add(reportDataSourse1);

                string reportType = "PDF";
                string mimeType;
                string encoding;
                string fileNameExtension;

                string deviceInfo =
                                            "<DeviceInfo>" +
                                            "  <OutputFormat>EMF</OutputFormat>" +
                                            "  <PageWidth>8.3in</PageWidth>" +
                                            "  <PageHeight>11.7in</PageHeight>" +
                                            "  <MarginTop>0in</MarginTop>" +
                                            "  <MarginLeft>0in</MarginLeft>" +
                                            "  <MarginRight>0in</MarginRight>" +
                                            "  <MarginBottom>0in</MarginBottom>" +
                                            "</DeviceInfo>";

                Microsoft.Reporting.WebForms.Warning[] warnings;
                string[] streams;
                byte[] renderedBytes;

                //Render the report
                renderedBytes = localReport.Render("EXCELOPENXML", null, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);

                string pathtMP = HttpContext.Current.Request.PhysicalApplicationPath + "tempreports\\";

                FileStream fs = new FileStream(pathtMP + "cuadreContable.xls",
                FileMode.Create);
                fs.Write(renderedBytes, 0, renderedBytes.Length);
                fs.Close();
            NotificacionCorreo.NotificadorClient svc= new NotificacionCorreo.NotificadorClient();
            NotificacionCorreo.clsCorreoAplicacion param = new NotificacionCorreo.clsCorreoAplicacion();
            System.Collections.Generic.Dictionary<string, string> parametros = new System.Collections.Generic.Dictionary<string, string>();
            param.CodigoAplicacion = Aplicacion;
            parametros.Add("Nombre", "A quien corresponda");
            parametros.Add("Descripcion", "El documento Excel con el cuadre contable.");
            string[] anexos = new string[] { pathtMP + "cuadreContable.xls" };
            try
            {
                var res = svc.EnviarCorreoVarios(correos, param, "Archivo cuadre Contable", parametros, anexos);
                if (res==0)
                {
                    lblMensajeExito.Text = "Archvio enviado con éxito.";
                    lblMensajeExito.Visible = true;
                }

            }
            catch (Exception ex)
            {
                fnMensajeError(ex.Message, true);
            }
        }

        private void fnMensajeError(string Mensaje, bool Mostrar)
        {
            lblMensajeError.Text = Mensaje;
            lblMensajeError.Visible = Mostrar;
        }
    }
}