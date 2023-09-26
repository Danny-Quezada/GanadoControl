using Data;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Models.DTO;
using Models.Entities;
using Models.Interfaces;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FarmacoController : ControllerBase
    {
        private readonly IFarmacoRepository farmacoRepository;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public FarmacoController(IFarmacoRepository farmacoRepository, IWebHostEnvironment webHostEnvironment)
        {
            this.farmacoRepository = farmacoRepository;
            _webHostEnvironment = webHostEnvironment;
        }

        [HttpGet("finca/{idFinca}")]
        public async Task<IActionResult> GetFarmacos([FromForm]int idFinca)
        {
            return Ok(await farmacoRepository.ObtenerFarmacosPorFinca(idFinca));
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromForm] DTOInsertarFarmaco farmacoDTO)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            Farmaco farmaco = new Farmaco()
            {
                Id = farmacoDTO.Id,
                FechaCaducidad = farmacoDTO.FechaCaducidad,
                FechaEntrega = farmacoDTO.FechaEntrega,
                IdFinca = farmacoDTO.IdFinca,
                Cantidad = farmacoDTO.Cantidad,
                Precio = farmacoDTO.Precio,
                Proveedor = farmacoDTO.Proveedor,
                Nombre = farmacoDTO.Nombre,
                Tipo= farmacoDTO.Tipo,
                UnidadMedida = farmacoDTO.UnidadMedida,
            };
            if (farmacoDTO.Foto != null)
            {
                using var stream = new MemoryStream();
                await farmacoDTO.Foto.CopyToAsync(stream);
                var bytes = stream.ToArray();
                farmaco.FotoURL = await CrearImagen(bytes, farmacoDTO.Foto.ContentType, Path.GetExtension(farmacoDTO.Foto.FileName), "FotosDeFarmacos", Guid.NewGuid().ToString());
            }
            return Ok(await farmacoRepository.Insertar(farmaco));
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put([FromForm] Farmaco farmaco, [FromForm]int id)
        {
            farmaco.Id = id;
            return Ok(await farmacoRepository.ActualizarFarmaco(farmaco));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete([FromForm] int id)
        {
            return Ok(await farmacoRepository.EliminarFarmaco(id));
        }
        [NoApiRoute]
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
