using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace ProyectoAndaluciaSvc.SVC
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "CargaDatosSvc" en el código, en svc y en el archivo de configuración a la vez.
    // NOTA: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione CargaDatosSvc.svc o CargaDatosSvc.svc.cs en el Explorador de soluciones e inicie la depuración.
    public class CargaDatosSvc : ICargaDatosSvc
    {
       
        public int CargarData(DTO.clsCargaDatos CargaDatos,out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarData(CargaDatos, out resultado);
        }
        public List<DTO.clsDiasFeriados> CargarDataFechas(DTO.clsFiltro filtro,out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarDataFechas(filtro,out resultado);
        }
        public int CargarData2101(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarData2101(CargaDatos, out resultado);
        }
        public int CargarData210105(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarData210105(CargaDatos, out resultado);
        }
        public int CargarData2105(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarData2105(CargaDatos, out resultado);
        }
        public int CargarData2103(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarData2103(CargaDatos, out resultado);
        }
        public int CargarData2105PF(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado)
        {
            BLL.bllCargaDatos bll = new BLL.bllCargaDatos();
            return bll.CargarData2105PF(CargaDatos, out resultado);
        }
    }
}
