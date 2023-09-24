using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DTO
{
    public class DAOGrupo
    {
        public int IdGrupo { get; set; }
        public int CantidadGanado { get; set; }
        public string FotoURL { get; set; }
    }
}
