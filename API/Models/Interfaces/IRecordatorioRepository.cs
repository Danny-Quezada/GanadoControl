using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IRecordatorioRepository : IRepository<Recordatorio>
    {
        Task<List<Recordatorio>> ObtenerRecordatoriosPorGanado(string idGanado);
        Task ActualizarRecordatorio(Recordatorio recordatorio);
        Task EliminarRecordatorio(int idRecordatorio);
    }
}
