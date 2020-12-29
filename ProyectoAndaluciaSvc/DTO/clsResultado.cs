using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace ProyectoAndaluciaSvc.DTO
{
    [DataContract(Name = "clsResultado", Namespace = "http://schemas.frameworks.com.ec/Games/2017/01")]
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

        [DataMember]
        public Decimal? TotalProducto { get; set; }         // Total columna Producto

        [DataMember]
        public Decimal? TotalCont { get; set; }         // Total columna Contabilidad
        [DataMember]
        public Decimal? TotalDif { get; set; }         // Total columna Diferencia

        [DataMember]
        public DateTime? FechaSd { get; set; }//fecha de saldo diario
        [DataMember]
        public DateTime? FechaCierre { get; set; }// fecha de cierre diario


    }
}
