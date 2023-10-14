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
        public GrupoController(IWebHostEnvironment _webHostEnvironment1, IGrupoRepository grupoRepository, IDetalleGrupoFotoRepository detalleGrupoFoto)
        {
            _webHostEnvironment = _webHostEnvironment1;
            this.grupoRepository = grupoRepository;
            this.detalleGrupofoto = detalleGrupoFoto;
        }
        IGrupoRepository grupoRepository;
        IDetalleGrupoFotoRepository detalleGrupofoto;
        private readonly IWebHostEnvironment _webHostEnvironment;
        [HttpPost]
        public async Task<IActionResult> InsertarGrupo([FromForm] DTOInsertGrupo dtogrupo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(dtogrupo is null)
            {
                return BadRequest("El objeto grupo es nulo");
            }
            try
            {
                DetalleGrupoFoto detalleGrupo = new DetalleGrupoFoto();
                if (dtogrupo.FotoURL != null)
                {
                    detalleGrupo.FotoURL = await ImageUtility.CrearImagen(dtogrupo.FotoURL, "FotosDeGrupos", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
                }
                Grupo grupo = new Grupo()
                {
                    IdFinca = dtogrupo.IdFinca,
                    Nombre = dtogrupo.Nombre,
                };
                int id = await grupoRepository.Insertar(grupo);
                detalleGrupo.IdGrupo = id;
                await detalleGrupofoto.Insertar(detalleGrupo);
                return Ok(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar grupo: {ex.Message}");
            }
        }
        [HttpGet("Finca/{id}")]
        public async Task<IActionResult> GetAllByFinca(int id)
        {
            try
            {
                return Ok(await grupoRepository.GetAllByFinca(id));
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
                return Ok(await grupoRepository.GetGrupo(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPut]
        public async Task<IActionResult> Put([FromForm] DTOInsertGrupo grupo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(grupo is null)
            {
                return BadRequest("El objeto grupo es nulo");
            }
            try
            {
                DAOGrupo dAOGrupo = new DAOGrupo();
                if (grupo.FotoURL != null)
                {
                    dAOGrupo.FotoURL = await ImageUtility.CrearImagen(grupo.FotoURL, "FotosDeGrupos", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
                }
                dAOGrupo.IdGrupo = grupo.IdGrupo;
                dAOGrupo.IdFinca = grupo.IdFinca;
                dAOGrupo.Nombre = grupo.Nombre;
                return Ok(await grupoRepository.UpdateGrupo(dAOGrupo));
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
                return Ok(await grupoRepository.DeleteGrupo(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
