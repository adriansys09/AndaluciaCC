using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace ProyectoAndaluciaNotificador
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "INotificador" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface INotificador
    {
        /// <summary>
        /// Permite Enviar mensajes de Correo a un solo destino
        /// </summary>
        /// <param name="destino">Dirección Email del correo de destino</param>
        /// <param name="asunto">Texto del asunto o encabezado del mensaje</param>
        /// <param name="plantillaHtml">Nombre de la plantilla HTML usado para enviar los mensajes</param>
        /// <param name="logotipoPng">Nombre del archivo que contiene el logotipo a ser enviado. En lo posible usar .png</param>
        /// <param name="firmaPng">Nombre del archivo que contiene la firma a ser enviada en modo gráfico</param>
        /// <param name="parametros">Conjunto de parámetros en formato Clave, Valor. Las claves van a ser reemplazadas en la plantilla con los campos $$ o con {{}} </param>
        /// <param name="anexos">Archivos anexos a ser incluidos</param>
        /// <returns>Retorna 0 si se envió el mensaje correctamente, caso contrario, retorna un código de error</returns>

        //int EnviarCorreo(string destino, string asunto, string plantillaHtml, string logotipoPng, string firmaPng,
        //              Dictionary<string, string> parametros, List<string> anexos);
        [OperationContract]
        DTO.clsResultado EnviarCorreo(DTO.clsCorreoAplicacion datosCorreo, string asunto, Dictionary<string, string> parametros, List<string> anexos);
        [OperationContract]
        int EnviarCorreoVarios(List<string> correosDesstino, DTO.clsCorreoAplicacion datosCorreo, string asunto, Dictionary<string, string> parametros, List<string> anexos);
    }
}
