using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DTO
{
    public class DTOInsertarGanado
    {
        public string IdGanado { get; set; }
        public string Raza { get; set; }
        public decimal Peso { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Tipo { get; set; }
        public string? IdPadre { get; set; }
        public string? IdMadre { get; set; }
        public int IdGrupo { get; set; }
        public IFormFile FotoURL { get; set; }
    }
}
