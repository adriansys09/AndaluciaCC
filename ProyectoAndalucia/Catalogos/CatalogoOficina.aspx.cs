using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoAndalucia.Catalogos
{
    public partial class CatalogoOficina : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FnCargarGrid();
                var a = Session["Login"].ToString();
            }
        }
        public void FnCargarGrid()
        {
            DataTable dt = new DataTable();

            DataColumn codigo = dt.Columns.Add("Codigo", typeof(Int32));
            DataColumn nombre = dt.Columns.Add("nombre", typeof(string));
            DataColumn apellido = dt.Columns.Add("apellido", typeof(string));

            DataRow row = dt.NewRow();
            row["codigo"] = this.gvDatos.Rows.Count + 1;
            row["nombre"] = "juna";
            row["apellido"] = "lopez";
            dt.Rows.Add(row);
            dt.AcceptChanges();

            gvDatos.DataSource = dt;
            gvDatos.DataBind();
        }
    }
}