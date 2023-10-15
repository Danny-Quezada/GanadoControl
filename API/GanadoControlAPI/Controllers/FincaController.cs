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
        private readonly IWebHostEnvironment _webHostEnvironment;
        [HttpPost]
        public async Task<IActionResult> InsertarFinca([FromForm] DTOInsertFinca dtofinca)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(dtofinca is null)
            {
                return BadRequest("El objeto Finca es nulo");
            }
            try
            {
                DetalleFincaFoto detalleFincaFoto = new DetalleFincaFoto();
                Finca finca = new Finca();
                if (dtofinca.FotoURL != null)
                {
                    detalleFincaFoto.FotoURL = await ImageUtility.CrearImagen(dtofinca.FotoURL, "FotosDeFincas", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
                }
                finca = new Finca()
                {
                    Nombre = dtofinca.Nombre,
                    NombreDueño = dtofinca.NombreDueño,
                    Ubicacion = dtofinca.Ubicacion,
                    Hectareas = dtofinca.Hectareas,

                };
                DetalleFinca detalleFinca = new DetalleFinca()
                {
                    IdUsuario = dtofinca.IdUsuario,
                    Fecha = dtofinca.Fecha,
                    RolUsuario = dtofinca.RolUsuario
                };
                int id = await fincaRepository.Insertar(finca);
                detalleFincaFoto.IdFinca = id;
                detalleFinca.IdFinca = id;
                await detalleFincaRepository.Insertar(detalleFinca);
                await fincaFotoRepository.Insertar(detalleFincaFoto);
                return Ok(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar finca: {ex.Message}");
            }
        }
        [HttpGet("Usuario/{id}")]
        public async Task<IActionResult> GetAllFincaByUsuario(int id)
        {
            try
            {
                return Ok(await fincaRepository.GetAllFincaByUsuario(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get([FromForm] int id)
        {
            try
            {
                return Ok(await fincaRepository.GetFinca(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPut]
        public async Task<IActionResult> Put([FromForm] DTOInsertFinca insertFinca)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(insertFinca is null)
            {
                return BadRequest("El objeto Finca es nulo");
            }
            try
            {
                DAOFinca finca = new DAOFinca();
                if (insertFinca.FotoURL != null)
                {
                    finca.FotoURL = await ImageUtility.CrearImagen(insertFinca.FotoURL, "FotosDeFincas", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
                }
                finca.IdFinca = insertFinca.IdFinca;
                finca.Nombre = insertFinca.Nombre;
                finca.Hectareas = insertFinca.Hectareas;
                finca.NombreDueño = insertFinca.NombreDueño;
                finca.Ubicacion = insertFinca.Ubicacion;
                return Ok(await fincaRepository.UpdateFinca(finca));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                return Ok(await fincaRepository.EliminarFinca(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("invitacion/{usuarioCreadorId}, {fincaId}, {rol}")]
        public async Task<IActionResult> Invitar(int usuarioCreadorId, int fincaId, string rol)
        {
            try
            {
                return Ok(await fincaRepository.InvitarAFinca(fincaId, usuarioCreadorId, rol));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPost("invitacion/{token}, {idUsuario}")]
        public async Task<IActionResult> IngresarPorInvitacion(string token, int idUsuario)
        {
            try
            {
                return Ok(await fincaRepository.VerificarInvitacion(token, idUsuario));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
