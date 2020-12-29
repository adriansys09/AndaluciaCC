using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoAndaluciaSvc.BLL
{
    public class bllCargaDatos
    {
        public int CargarData(DTO.clsCargaDatos CargaDato,out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarData(CargaDato, out resultado);
        }
        public List<DTO.clsDiasFeriados> CargarDataFechas(DTO.clsFiltro filtro, out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarDataFechas(filtro,out resultado);
        }
        public int CargarData2101(DTO.clsCargaDatos CargaDato, out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarData2101(CargaDato, out resultado);
        }

        public int CargarData210105(DTO.clsCargaDatos CargaDato, out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarData210150(CargaDato, out resultado);
        }
        public int CargarData2105(DTO.clsCargaDatos CargaDato, out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarData2105(CargaDato, out resultado);
        }
        public int CargarData2103(DTO.clsCargaDatos CargaDato, out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarData2103(CargaDato, out resultado);
        }
        public int CargarData2105PF(DTO.clsCargaDatos CargaDato, out DTO.clsResultado resultado)
        {
            DAL.dalCargarData dal = new DAL.dalCargarData();
            return dal.CargarData2105PF(CargaDato, out resultado);
        }
    }
}