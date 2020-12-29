using System;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LOGI;
using INFO;
using System.Data;

namespace ProyectoAndalucia.Referidos
{
    public partial class ConsultaPuntos : System.Web.UI.Page
    {
        int idUsuario = ProyectoAndalucia.Inicio.IdUsuario;
        int idRolAcceso = ProyectoAndalucia.Inicio.RolAcceso;
        List<int> idRolUsuario = ProyectoAndalucia.Inicio.RolUsuario;
        String menu = "REF3";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sesion();
                CargarPuntosConsolidado();
                CargarPremios();
                FnTotalPuntos();
                FnCargarUsuarioCanje();
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


        private void CargarPuntosConsolidado()
        {
            ReferidosLogi refLog = new ReferidosLogi();
            gdvConsolidado.DataSource = refLog.ConsultarPuntosConsolidados(idUsuario);
            gdvConsolidado.DataBind();
        }
        private void CargarPremios()
        {
            ReferidosLogi refLog = new ReferidosLogi();
            gdvPremios.DataSource = refLog.ConsultarPremios("PR");
            gdvPremios.DataBind();
        }

        private void FnTotalPuntos()
        {
            ReferidosLogi refLog = new ReferidosLogi();
            DataTable datoPuntos = new DataTable();
            datoPuntos = refLog.ConsultarPuntosConsolidados(idUsuario);
            int suma = 0;

            for (int i = 0; i < datoPuntos.Rows.Count; i++)
            {
                suma += int.Parse(datoPuntos.Rows[i]["PUNTOS"].ToString());
            }

            lblPuntos.Text = suma.ToString();
        }

        protected void btn_canjear_Click(object sender, EventArgs e)
        {
            ReferidosLogi refCanje = new ReferidosLogi();
            List<RefCanjeInfo> listaCanje = new List<RefCanjeInfo>();
            RefCanjeInfo canje = new RefCanjeInfo();
            

            try
            {
                CargaPremiosChe();
                if (int.Parse(lblPuntos.Text) == 0 || int.Parse(lblPuntos.Text) < int.Parse(lblPuntos.Text.ToString()))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Los puntos " + lblPuntos.Text + " no son suficientes para canjeae el premio. " + "');", true);
                    return;
                } else if (int.Parse(lblPuntoPre.Text) > int.Parse(lblPuntos.Text.ToString()))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Los puntos " + lblPuntos.Text + " no son suficientes para canjeae el premio. " + "');", true);
                    return;
                }

                listaCanje = refCanje.InsertarPremiosCanje(FnCargarCanje());
                string listInsertLog = refCanje.rf_InsertLog("ILOG", idUsuario, idUsuario.ToString(), "", "COLA1", "Solicitud de canje de puntos");
                canje = (RefCanjeInfo)listaCanje[0];
                FnEnviarCorreo(canje.Id);
                FnCargarUsuarioCanje();

                if (listaCanje.Count > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Registro exitoso." + "');", true);
                }
                Response.Redirect("~/Referidos/ConsultaPuntos.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + ex.Message + "');", true);
            }
        }

        private RefCanjeInfo FnCargarCanje()
        {
            RefCanjeInfo canje = new RefCanjeInfo();
            
            canje.Id = 0;
            canje.Premio = Convert.ToInt32(lblIdPremio.Text);
            canje.Empleado = idUsuario;
            canje.Puntos_prem = int.Parse(lblPuntoPre .Text); 
            canje.Puntos_disp = int.Parse(lblPuntos.Text);
            canje.Estado = "I";
            canje.Observacion = "";
            return canje;
        }

        private void FnCargarUsuarioCanje()
        {
            ReferidosLogi logRef = new ReferidosLogi();
            gvCanjes.DataSource = logRef.ConsultarPremiosEmpleado("CC",0, idUsuario);
            gvCanjes.DataBind();
        }

        protected void gdvPremios_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gdvPremios.SelectedRow;
            string id =row.Cells[2].Text .ToString ();
        }
        private string FnEnviarCorreo(int p_id)
        {
            ReferidosLogi logRef = new ReferidosLogi();
            string p_respuesta = ""; string p_mail = "";
            DataTable datos = new DataTable();
            SendMail ennmail = new SendMail();

            try
            {
                datos = logRef.ConsultarPremiosEmpleado("CM", p_id, ProyectoAndalucia.Inicio.IdUsuario);
                foreach (DataRow row in datos.Rows)
                {
                    p_mail = row["mail"].ToString();
                }
                p_respuesta = ennmail.EnviarMail(p_mail, datos);
            }
            catch (Exception ex)
            {
                p_respuesta = ex.Message;
            }
            finally
            {
                p_respuesta = "";
            }
            return p_respuesta;
        }

        private void CargaPremiosChe()
        {
            string pd_des = "0"; string pd_puntos = "0"; string id_premio = "0";

            foreach (GridViewRow row in gdvPremios.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("lblSelect") as CheckBox);
                    if (chkRow.Checked)
                    {
                        id_premio = row.Cells[1].Text;
                        pd_des = row.Cells[2].Text;
                        pd_puntos = row.Cells[3].Text;
                    }
                }
            }
            lblPuntoPre.Text = pd_puntos;
            lblIdPremio.Text = id_premio;
        }
    }
}