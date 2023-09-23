using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class DetalleFinca
    {
        public int IdDetalleFinca { get; set; }
        public int IdUsuario { get; set; }
        public int IdFinca { get; set; }
        public DateTime Fecha { get; set; }
    }
}
