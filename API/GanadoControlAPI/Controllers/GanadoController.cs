using Data;
using Microsoft.AspNetCore.Mvc;
using Models.DTO;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GanadoController : ControllerBase
    {
        public GanadoController(IWebHostEnvironment _webHostEnvironment1)
        {
            _webHostEnvironment = _webHostEnvironment1;
        }
        IGanadoRepository ganadoRepository = new GanadoData();
        IDetalleGanadoRepository detalleGanadoRepository = new DetalleGanadoData();
        [HttpPost]
        public async Task<IActionResult> InsertarGanado([FromForm] DTOInsertarGanado dtoganado)
        {
            DetalleGanado detalleGanado = new DetalleGanado();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (dtoganado.FotoURL != null)
            {
                using var stream = new MemoryStream();
                await dtoganado.FotoURL.CopyToAsync(stream);
                var bytes = stream.ToArray();

                detalleGanado.FotoURL = await CrearImagen(bytes, dtoganado.FotoURL.ContentType, Path.GetExtension(dtoganado.FotoURL.FileName), "FotosDeGanados", Guid.NewGuid().ToString());
            }
            Ganado ganado = new Ganado()
            {
                FechaNacimiento = dtoganado.FechaNacimiento,
                IdGrupo = dtoganado.IdGrupo,
                IdMadre = dtoganado.IdMadre,
                IdPadre = dtoganado.IdPadre,
                Raza = dtoganado.Raza,
                Peso = dtoganado.Peso,
                Tipo = dtoganado.Tipo,
                IdGanado = dtoganado.IdGanado,
            };
            await ganadoRepository.Insertar(ganado);
            detalleGanado.IdGanado = dtoganado.IdGanado;
            await detalleGanadoRepository.Insertar(detalleGanado);
            return Created("Creado", true);
        }
        [HttpGet("Grupo/{id}")]
        public async Task<IActionResult> GetAll(int id)
        {
            return Ok(await ganadoRepository.GetAllGanadoByGrupo(id));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetGanado(string id)
        {
            return Ok(await ganadoRepository.GetGanado(id));
        }
        private readonly IWebHostEnvironment _webHostEnvironment;
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
