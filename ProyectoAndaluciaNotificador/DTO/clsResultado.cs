using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace ProyectoAndaluciaNotificador.DTO
{
    [DataContract(Name = "clsResultado", Namespace = "http://schemas.frameworks.com.ec/ProyectoCuadresSQL/2020/9")]
    public class clsResultado
    {
        [DataMember]
        public int Resultado { get; set; }         // Código de resultado de la ejecución del proceso. Si retorna 0 es OK, positivos son mensajes para el usuario, negativos solo internos
        [DataMember]
        public string Mensaje { get; set; }         // Mensaje a ser presentado al usuario
       
        [DataMember]
        public int? TotalPaginas { get; set; }           // Número de páginas, de acuerdo a la consulta
        [DataMember]
        public string Autoriza { get; set; }
        [DataMember]
        public int? CodTran { get; set; }
        [DataMember]
        public int? TotalRegistros { get; set; }
        [DataMember]
        public string MensajeAuxiliar1 { get; set; }         // Mensaje Auxiliar
        [DataMember]
        public string MensajeAuxiliar2 { get; set; }         // Mensaje Auxiliar
        [DataMember]
        public string MensajeAuxiliar3 { get; set; }         // Mensaje Auxiliar
    }
}
