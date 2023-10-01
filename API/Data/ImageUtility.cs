using Microsoft.AspNetCore.Http;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Data
{
    public static class ImageUtility
    {
        public static async Task<string> CrearImagen(IFormFile image, string container, string wwwrootPath, string scheme, string host)
        {
            using var stream = new MemoryStream();
            await image.CopyToAsync(stream);
            var bytes = stream.ToArray();
            if (string.IsNullOrEmpty(wwwrootPath))
            {
                throw new Exception("La ruta es nula o está vacía");
            }
            string carpetaArchivo = Path.Combine(wwwrootPath, container);
            if (!Directory.Exists(carpetaArchivo))
            {
                Directory.CreateDirectory(carpetaArchivo);
            }
            string nombreFinal = $"{Guid.NewGuid()}{Path.GetExtension(image.FileName)}";
            string rutaFinal = Path.Combine(carpetaArchivo, nombreFinal);
            await File.WriteAllBytesAsync(rutaFinal, bytes);
            string urlActual = $"{scheme}://{host}";
            string dbUrl = Path.Combine(urlActual, container, nombreFinal).Replace("\\", "/");
            return dbUrl;
        }
    }
}
