using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class DetalleFinca
    {
        public int IdUsuario { get; set; }
        public int IdFinca { get; set; }
        public DateTime Fecha { get; set; }
        public string RolUsuario { get; set; }
    }
}
