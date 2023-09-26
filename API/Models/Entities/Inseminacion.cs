using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class Inseminacion
    {
        public int Id { get; set; }
        public string IdGanado { get; set; }
        public DateTime FechaInseminacion { get; set; }
    }
}
