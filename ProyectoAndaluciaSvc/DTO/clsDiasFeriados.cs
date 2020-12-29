using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace ProyectoAndaluciaSvc.DTO
{
    [DataContract(Name = "clsDiasFeriados", Namespace = "http://schemas.frameworks.com.ec/ProyectoAndaluciaSvc/2020/9")]
    public class clsDiasFeriados
    {
        [DataMember]
        public DateTime? Fecha { get; set; }
        [DataMember]
        public int? Ciudad { get; set; }
        [DataMember]
        public int? Codigo { get; set; }
    }
}