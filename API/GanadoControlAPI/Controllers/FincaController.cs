using Data;
using Microsoft.AspNetCore.Mvc;
using Models.DTO;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    //private readonly IWebHostEnvironment _webHostEnvironment;
    [Route("api/[controller]")]
    [ApiController]

    public class FincaController : ControllerBase
    {
        public FincaController(IWebHostEnvironment _webHostEnvironment1)
        {
            _webHostEnvironment = _webHostEnvironment1;
        }
        IFincaRepository fincaRepository = new FincaData();
        IDetalleFincaFotoRepository fincaFotoRepository = new DetalleFincaFotoData();
        [HttpPost]
        public async Task<IActionResult> InsertarFinca([FromForm] DTOInsertFinca dtofinca)
        {
            DetalleFincaFoto detalleFincaFoto = new DetalleFincaFoto();
            Finca finca = new Finca();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (dtofinca.FotoURL != null)
            {
                using var stream = new MemoryStream();
                await dtofinca.FotoURL.CopyToAsync(stream);
                var bytes = stream.ToArray();

                detalleFincaFoto.FotoURL = await CrearImagen(bytes, dtofinca.FotoURL.ContentType, Path.GetExtension(dtofinca.FotoURL.FileName), "FotosDeFincas", Guid.NewGuid().ToString());
            }
            finca = new Finca()
            {
                Nombre = dtofinca.Nombre,
                NombreDueño = dtofinca.NombreDueño,
                Ubicacion = dtofinca.Ubicacion,
                Hectareas = dtofinca.Hectareas,

            };
            await fincaRepository.Insertar(finca);
            detalleFincaFoto.IdFinca = fincaRepository.GetLastId().Result;
            await fincaFotoRepository.Insertar(detalleFincaFoto);
            //  await finca
            return Created("Creado", true);
        }
        [HttpGet("Usuario/{id}")]
        public async Task<IActionResult> GetAllFincaByUsuario(int id)
        {
            return Ok(await fincaRepository.GetAllFincaByUsuario(id));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await fincaRepository.GetFinca(id));
        }
        //////////////////
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
    [AttributeUsage(AttributeTargets.Method)]
    public class NoApiRouteAttribute : Attribute
    {
    }
}
