using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ProyectoAndaluciaNotificador.DTO
{
    [DataContract(Name = "clsFiltro", Namespace = "http://schemas.frameworks.com.ec/ProyectoCuadresSQL/2020/9")]
    public class clsFiltro
    {
        public String p_login { get; set; }
        public String p_operacion { get; set; }
        public Int32? p_modo { get; set; }
        public Int32? p_oficina { get; set; }
        public Int32? p_filial { get; set; }
        public Int32? trn { get; set; }
        public String p_sesion { get; set; }
        public String p_cadena { get; set; }
        public String Terminal { get; set; }
        public Int64 Rol { get; set; }
        public Int64? Oficina{get; set; }
        public string Usuario{get;set;}
        //filtro sps
        public int? Id { get; set; }
        public string Filtro { get; set; }
        public string Orden { get; set; }
        public int? Pagina { get; set; }
        public int? Filas { get; set; }
        public int? Modo { get; set; }
        public String Fecha { get; set; }
    }
}
