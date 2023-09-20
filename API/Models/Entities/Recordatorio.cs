using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class Recordatorio
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string IdGanado { get; set; }
    }
}
