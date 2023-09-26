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
        public FincaController(IWebHostEnvironment _webHostEnvironment1, IFincaRepository fincaRepository, IDetalleFincaFotoRepository detalleFincaFotoRepository, IDetalleFincaRepository detalleFincaRepository)
        {
            _webHostEnvironment = _webHostEnvironment1;
            this.fincaRepository = fincaRepository;
            this.fincaFotoRepository = detalleFincaFotoRepository;
            this.detalleFincaRepository = detalleFincaRepository;
        }
        IFincaRepository fincaRepository;
        IDetalleFincaFotoRepository fincaFotoRepository;
        IDetalleFincaRepository detalleFincaRepository;
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
            DetalleFinca detalleFinca= new DetalleFinca()
            {
                IdFinca = dtofinca.IdFinca,
                IdUsuario = dtofinca.IdUsuario,
                Fecha = dtofinca.Fecha,
                RolUsuario = dtofinca.RolUsuario
            };
            await fincaRepository.Insertar(finca);
            detalleFincaFoto.IdFinca = fincaRepository.GetLastId().Result;
            await detalleFincaRepository.Insertar(detalleFinca);
            await fincaFotoRepository.Insertar(detalleFincaFoto);
            return Ok (detalleFincaFoto.IdFinca);
        }
        [HttpGet("Usuario/{id}")]
        public async Task<IActionResult> GetAllFincaByUsuario([FromForm] int id)
        {
            return Ok(await fincaRepository.GetAllFincaByUsuario(id));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get([FromForm] int id)
        {
            return Ok(await fincaRepository.GetFinca(id));
        }
        [HttpPut]
        public async Task<IActionResult> Put([FromForm] DTOInsertFinca insertFinca)
        {
            DAOFinca finca = new DAOFinca();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (insertFinca.FotoURL != null)
            {
                using var stream = new MemoryStream();
                await insertFinca.FotoURL.CopyToAsync(stream);
                var bytes = stream.ToArray();

                finca.FotoURL = await CrearImagen(bytes, insertFinca.FotoURL.ContentType, Path.GetExtension(insertFinca.FotoURL.FileName), "FotosDeFincas", Guid.NewGuid().ToString());
            }
            finca.IdFinca = insertFinca.IdFinca;
            finca.Nombre = insertFinca.Nombre;
            finca.Hectareas = insertFinca.Hectareas;
            finca.NombreDueño = insertFinca.NombreDueño;
            finca.Ubicacion = insertFinca.Ubicacion;
            await fincaRepository.UpdateFinca(finca);
           return Ok("Actualizado Correctamente");
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
