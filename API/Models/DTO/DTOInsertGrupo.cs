using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DTO
{
    public class DTOInsertGrupo
    {
        public string Nombre { get; set; }
        public int IdFinca { get; set; }
        public IFormFile FotoURL { get; set; }
    } 
}
