using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DTO
{
    public class DTOInsertarFarmaco
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Proveedor { get; set; }
        public string Tipo { get; set; }
        public string UnidadMedida { get; set; }
        public DateTime FechaCaducidad { get; set; }
        public DateTime FechaEntrega { get; set; }
        public float Precio { get; set; }
        public int Cantidad { get; set; }
        public IFormFile? Foto { get; set; }
        public int IdFinca { get; set; }
    }
}
