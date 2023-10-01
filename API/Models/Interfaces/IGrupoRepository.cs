using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IGrupoRepository : IData<Grupo>
    {
        public Task<List<DAOGrupo>> GetAllByFinca(int IdFinca);
        public Task<DAOGrupo> GetGrupo(int id);
        public Task<bool> UpdateGrupo(DAOGrupo grupo);
        public Task<bool> DeleteGrupo(int id);
    }
}
