using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface ITratamientoRepository: IRepository<Tratamiento>
    {
        Task<List<TratamientoDAO>> ObtenerTratamientosPorUsuario(int idUsuario);
        Task<List<TratamientoDAO>> ObtenerTratamientoPorGanado(string idGanado);
        Task<List<TratamientoDAO>> ObtenerTratamientoPorGrupo(int idGrupo);
        Task<List<TratamientoDAO>> ObtenerTratamientoPorFinca(int idFinca);
    }
}
