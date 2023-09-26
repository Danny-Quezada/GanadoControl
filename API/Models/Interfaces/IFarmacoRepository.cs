using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public  interface IFarmacoRepository: IData<Farmaco>
    {
        Task<List<Farmaco>> ObtenerFarmacosPorFinca(int idFinca);
        Task<bool> ActualizarFarmaco(Farmaco farmaco);
        Task<bool> EliminarFarmaco(int id);
    }
}
