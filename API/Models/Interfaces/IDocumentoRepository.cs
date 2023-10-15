using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IDocumentoRepository
    {
        Task<List<Documento>> MostrarDocumentos();
        Task<string?> ObtenerDocumento(int id);
    }
}
