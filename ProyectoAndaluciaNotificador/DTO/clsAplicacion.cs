using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;


namespace ProyectoAndaluciaNotificador.DTO
{
    [DataContract(Name = "clsAplicacion", Namespace = "http://schemas.frameworks.com.ec/ProyectoCuadresSQL/2020/9")]
    public class clsAplicacion
	{
		[DataMember]
		public String Codigo { get; set; }
		[DataMember]
		public String Nombre { get; set; }
		[DataMember]
		public String Descripcion { get; set; }
		[DataMember]
		public String Estado { get; set; }

		[DataMember]
		public DateTime? Version { get; set; }

		[DataMember]
		public string FuncionarioTran { get; set; }   // Funcionario que ejecuta la transacción
	}

}