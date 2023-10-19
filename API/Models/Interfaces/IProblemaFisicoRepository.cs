using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IProblemaFisicoRepository : IData<ProblemaFisico>
    {
        Task<List<ProblemaFisico>> ObtenerProblemasFisicosPorGanado(string idGanado);
        Task<bool> EliminarProblemaFisico(int idProblemaFisico);
        Task<bool> ActualizarProblemaFisico(ProblemaFisico problemaFisico);
        Task<List<DTOGrafDaños>> GrafPartesDañadas(int IdUsuario);
    }
}
