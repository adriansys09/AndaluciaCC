using System;
using System.Collections;
using System.Data;
using ProyectoAndaluciaNotificador.DTO;
using Sybase.Data.AseClient;
//using INFO;

namespace ProyectoAndaluciaNotificador.DAL
{
    public class ConexionData
    {
        //private AseConnection conn;

        //  //Funciones Propias
        //public AseConnection ConexionBdd(string conexionString, out clsResultado resultado)
        //{
        //    DTO.ConexionInfo conInf = new DTO.ConexionInfo(conexionString);
        //    try
        //    {
        //        conn = new AseConnection(conInf.ConectionStrin);
        //        conn.Open();
        //    }
        //    catch (AseException ex)
        //    {
        //        conn = null;
        //        throw new System.InvalidCastException("No se pudo establecer la conexion a la base de datos.", ex);

        //    }
        //    return conn;
        //}

        ////Cerrar la conexion
        //public bool CerrarConexion()
        //{
        //    try
        //    {
        //        conn.Close();
        //        conn = null;
        //        return true;
        //    }
        //    catch (AseException ex)
        //    {
        //        conn = null;
        //        return false;
        //        throw new Exception(ex.Message);
        //    }
        //}

        ////verificar conexion 
        //public bool verificarConexion()
        //{
        //    try
        //    {
        //        if (conn.State.Equals("Open"))
        //        {
        //            return true;
        //        }
        //        else
        //        {
        //            conn = null;
        //            return false;
        //        }
        //    }
        //    catch (AseException ex)
        //    {
        //        conn = null;
        //        return false;
        //        throw new Exception(ex.Message);
        //    }
        //}

        
       
    }
}
