using Data;
using Microsoft.AspNetCore.Mvc;
using Models.DTO;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GrupoController:ControllerBase
    {
        public GrupoController(IWebHostEnvironment _webHostEnvironment1)
        {
            _webHostEnvironment = _webHostEnvironment1;
        }
        IGrupoRepository grupoRepository = new GrupoData();
        IDetalleGrupoFotoRepository detalleGrupofoto = new DetalleGrupoFotoData();
        [HttpPost]
        public async Task<IActionResult> InsertarGrupo([FromForm] DTOInsertGrupo dtogrupo)
        {
          //  DTOInsertGrupo dtogrupo = new DTOInsertGrupo();
            DetalleGrupoFoto detalleGrupo = new DetalleGrupoFoto();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (dtogrupo.FotoURL != null)
            {
                using var stream = new MemoryStream();
                await dtogrupo.FotoURL.CopyToAsync(stream);
                var bytes = stream.ToArray();

                detalleGrupo.FotoURL = await CrearImagen(bytes, dtogrupo.FotoURL.ContentType, Path.GetExtension(dtogrupo.FotoURL.FileName), "FotosDeGrupos", Guid.NewGuid().ToString());
            }
            Grupo grupo = new Grupo()
            {
                IdFinca = dtogrupo.IdFinca,
                Nombre = dtogrupo.Nombre,

            };
            await grupoRepository.Insertar(grupo);
            detalleGrupo.IdGrupo = await grupoRepository.GetLastId();
            await detalleGrupofoto.Insertar(detalleGrupo);
            return Created("Creado", true);
        }
        [HttpGet("Finca/{id}")]
        public async Task<IActionResult> GetAllByFinca(int id)
        {
            return Ok(await grupoRepository.GetAllByFinca(id));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await grupoRepository.GetGrupo(id));
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
