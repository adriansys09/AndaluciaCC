using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;


namespace ProyectoAndaluciaNotificador.DTO
{
    [DataContract(Name = "clsCorreoAplicacion", Namespace = "http://schemas.frameworks.com.ec/ProyectoCuadresSQL/2020/9")]
    public class clsCorreoAplicacion
    {
        [DataMember]
        public Int32? Codigo { get; set; }
        [DataMember]
        public String CodigoAplicacion { get; set; }
        [DataMember]
        public String UserOrigen { get; set; }
        [DataMember]
        public String ClaveOrigen { get; set; }
        [DataMember]
        public String SmtpServer { get; set; }
        [DataMember]
        public Int32? SmtpServerPort { get; set; }
        [DataMember]
        public String SmtpServerSsl { get; set; }
        [DataMember]
        public DateTime? Version { get; set; }
        [DataMember]
        public String PlantillaHtml { get; set; }
        [DataMember]
        public String Logotipo { get; set; }
        [DataMember]
        public String Firma{ get; set; }
        [DataMember]
        public String Destino { get; set; }
        [DataMember]
		public string FuncionarioTran { get; set; }   // Funcionario que ejecuta la transacción
	}

}