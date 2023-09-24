using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IGrupoRepository : IRepository<Grupo>
    {
        public Task<List<DAOGrupo>> GetAllByFinca(int IdFinca);
        public Task<Grupo> GetGrupo(int id);
        public Task<int> GetLastId();
    }
}
