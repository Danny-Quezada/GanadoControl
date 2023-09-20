using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Models.Entities
{
    public class ProblemaFisico
    {
        public int Id { get; set; }
        public string IdGanado { get; set; }
        public string NombreParte { get; set; }
        public string Descripcion { get; set; }
    }
}
