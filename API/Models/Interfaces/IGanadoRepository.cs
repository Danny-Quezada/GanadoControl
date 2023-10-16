using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IGanadoRepository : IRepository<Ganado>
    {
        Task<List<DAOGanado>> GetAllGanadoByGrupo(int IdGrupo);
        Task<DAOGanado> GetGanado(string id);
        Task<bool> UpdateGanado(DAOGanado ganado);
        Task<DTOGrafVacunas> GrafVacunas(int IdGrupo);
    }
}
