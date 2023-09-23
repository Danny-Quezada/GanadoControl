using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class Parto
    {
        public int Id { get; set; }
        public string IdGanado { get; set; }
        public string Tipo { get; set; }
        public bool Exitoso { get; set; }
        public DateTime Fecha { get; set; }
    }
}
