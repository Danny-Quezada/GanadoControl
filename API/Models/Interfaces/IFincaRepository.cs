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
    public interface IFincaRepository : IRepository<Finca>
    {
       Task<List<DAOFinca>> GetAllFincaByUsuario(int IdUsuario);
        Task<Finca> GetFinca(int Id);
        Task<int> GetLastId();
    }
}
