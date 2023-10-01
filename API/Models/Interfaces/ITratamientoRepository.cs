using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface ITratamientoRepository: IData<Tratamiento>
    {
        Task<List<DAOTratamiento>> ObtenerTratamientosPorUsuario(int idUsuario);
        Task<List<DAOTratamiento>> ObtenerTratamientoPorGanado(string idGanado);
        Task<List<DAOTratamiento>> ObtenerTratamientoPorGrupo(int idGrupo);
        Task<List<DAOTratamiento>> ObtenerTratamientoPorFinca(int idFinca);
    }
}
