using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IFincaRepository : IData<Finca>
    {
        Task<List<DAOFinca>> GetAllFincaByUsuario(int IdUsuario);
        Task<DAOFinca> GetFinca(int Id);
        Task<bool> UpdateFinca(DAOFinca DAOFinca);
        Task<bool> EliminarFinca(int id);
    }
}
