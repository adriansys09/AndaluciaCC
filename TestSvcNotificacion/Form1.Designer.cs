namespace TestSvcNotificacion
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblNroAplicacion = new System.Windows.Forms.Label();
            this.txtAplicacion = new System.Windows.Forms.TextBox();
            this.btnEnviarCorreo = new System.Windows.Forms.Button();
            this.txtresultado = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // lblNroAplicacion
            // 
            this.lblNroAplicacion.AutoSize = true;
            this.lblNroAplicacion.Location = new System.Drawing.Point(27, 13);
            this.lblNroAplicacion.Name = "lblNroAplicacion";
            this.lblNroAplicacion.Size = new System.Drawing.Size(79, 13);
            this.lblNroAplicacion.TabIndex = 0;
            this.lblNroAplicacion.Text = "Nro. Aplicacion";
            // 
            // txtAplicacion
            // 
            this.txtAplicacion.Location = new System.Drawing.Point(135, 5);
            this.txtAplicacion.Name = "txtAplicacion";
            this.txtAplicacion.Size = new System.Drawing.Size(100, 20);
            this.txtAplicacion.TabIndex = 1;
            // 
            // btnEnviarCorreo
            // 
            this.btnEnviarCorreo.Location = new System.Drawing.Point(297, 1);
            this.btnEnviarCorreo.Name = "btnEnviarCorreo";
            this.btnEnviarCorreo.Size = new System.Drawing.Size(75, 23);
            this.btnEnviarCorreo.TabIndex = 2;
            this.btnEnviarCorreo.Text = "Enviar";
            this.btnEnviarCorreo.UseVisualStyleBackColor = true;
            this.btnEnviarCorreo.Click += new System.EventHandler(this.btnEnviarCorreo_Click);
            // 
            // txtresultado
            // 
            this.txtresultado.Location = new System.Drawing.Point(30, 149);
            this.txtresultado.Multiline = true;
            this.txtresultado.Name = "txtresultado";
            this.txtresultado.Size = new System.Drawing.Size(430, 107);
            this.txtresultado.TabIndex = 3;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(575, 368);
            this.Controls.Add(this.txtresultado);
            this.Controls.Add(this.btnEnviarCorreo);
            this.Controls.Add(this.txtAplicacion);
            this.Controls.Add(this.lblNroAplicacion);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblNroAplicacion;
        private System.Windows.Forms.TextBox txtAplicacion;
        private System.Windows.Forms.Button btnEnviarCorreo;
        private System.Windows.Forms.TextBox txtresultado;
    }
}

