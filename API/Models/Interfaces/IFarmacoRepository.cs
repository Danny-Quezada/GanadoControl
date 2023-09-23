using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public  interface IFarmacoRepository: IRepository<Farmaco>
    {
        Task<List<Farmaco>> ObtenerFarmacosPorFinca(int idFinca);
        Task ActualizarFarmaco(Farmaco farmaco);
        Task EliminarFarmaco(int id);
    }
}
