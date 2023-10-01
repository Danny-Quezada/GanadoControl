using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IRecordatorioRepository : IData<Recordatorio>
    {
        Task<List<Recordatorio>> ObtenerRecordatoriosPorGanado(string idGanado);
        Task<bool> ActualizarRecordatorio(Recordatorio recordatorio);
        Task<bool> EliminarRecordatorio(int idRecordatorio);
    }
}
