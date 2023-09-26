using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DTO
{
    public class DTOInsertFinca
    {
        public int IdFinca { get; set; }
        public string Nombre { get; set; }
        public string Ubicacion { get; set; }
        public int Hectareas { get; set; }
        public string NombreDueño { get; set; }
        public IFormFile FotoURL { get; set; }
        public int IdUsuario { get; set; }
        public DateTime Fecha { get; set; }
        public string RolUsuario { get; set; }
    }
}
