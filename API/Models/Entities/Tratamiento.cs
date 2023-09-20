using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class Tratamiento
    {
        public int Id { get; set; }
        public string IdGanado { get; set; }
        public int IdFarmaco { get; set; }
        public DateTime Fecha { get; set; }
        public string Tipo { get; set; }
        public float Dosis { get; set; }
        public string Observacion { get; set; }
        public string AreaAplicacion { get; set; }
    }
}
