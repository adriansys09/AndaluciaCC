using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;


namespace ProyectoAndaluciaSvc.DTO
{
    [DataContract(Name = "clsCargaDatos", Namespace = "http://schemas.frameworks.com.ec/ProyectoAndaluciaSvc/2020/9")]
    public class clsCargaDatos
    {
        [DataMember]
        public String Finmes { get; set; }
        [DataMember]
        public DateTime? Fechadesde { get; set; }
        [DataMember]
        public DateTime? FechaHasta { get; set; }
        [DataMember]
        public String Producto { get; set; }
        [DataMember]
        public String Encaje { get; set; }
        [DataMember]
        public DateTime? FechaSd { get; set; }
        [DataMember]
        public DateTime? FechaCierre { get; set; }
        [DataMember]
        public Int32? DiasIni { get; set; }
        

    }
   


}