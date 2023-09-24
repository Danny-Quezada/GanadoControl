using Data;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleFincaFotoController : ControllerBase
    {
        
        IDetalleFincaFotoRepository detalleFincaFotoRepository = new DetalleFincaFotoData();
        [HttpPost]
        public async Task<IActionResult> Insertar([FromBody] DetalleFincaFoto detalleFincaFoto)
        {

            await detalleFincaFotoRepository.Insertar(detalleFincaFoto);
            return Created("Creado", true);
        }
        private readonly IWebHostEnvironment _webHostEnvironment;
        private async Task<String> CrearImagen(byte[] file, string contentType, string extension, string container, string nombre)
        {
            string wwwrootPath = _webHostEnvironment.WebRootPath;


            if (string.IsNullOrEmpty(wwwrootPath))
            {
                throw new Exception();
            }

            string carpetaArchivo = Path.Combine(wwwrootPath, container);
            if (!Directory.Exists(carpetaArchivo))
            {
                Directory.CreateDirectory(carpetaArchivo
                    );
            }
            string nombreFinal = $"{nombre}{extension}";
            string rutaFinal = Path.Combine(carpetaArchivo, nombreFinal);

            await System.IO.File.WriteAllBytesAsync(rutaFinal, file);
            string urlActual = $"{HttpContext.Request.Scheme}://{HttpContext.Request.Host}";

            string dbUrl = Path.Combine(urlActual, container, nombreFinal).Replace("\\", "/");
            return dbUrl;

        }
    }
}
