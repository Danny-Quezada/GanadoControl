using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DTO
{
    public class DTOGanado
    {
        public string IdGanado { get; set; }
        public string Tipo { get; set; }
        public DateTime? UltimaVacuna { get; set; }
        public DateTime? Ultimadesparacitacion { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public string? Raza { get; set; }
        public float Peso { get; set; }
    }
}
