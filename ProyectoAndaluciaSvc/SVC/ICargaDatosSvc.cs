using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace ProyectoAndaluciaSvc.SVC
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "ICargaDatosSvc" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface ICargaDatosSvc
    {
        [OperationContract]
        int CargarData(DTO.clsCargaDatos Cuenta,out DTO.clsResultado resultado);
        [OperationContract]
        List<DTO.clsDiasFeriados> CargarDataFechas(DTO.clsFiltro filtro,out DTO.clsResultado resultado);
        [OperationContract]
        int CargarData2101(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado);
        [OperationContract]
        int CargarData210105(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado);
        [OperationContract]
        int CargarData2105(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado);
        [OperationContract]
        int CargarData2103(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado);
        [OperationContract]
        int CargarData2105PF(DTO.clsCargaDatos CargaDatos, out DTO.clsResultado resultado);
    }
}
