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
            DetalleGrupoFoto detalleGrupo = new DetalleGrupoFoto();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
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
        [HttpGet("Finca/{id}")]
        public async Task<IActionResult> GetAllByFinca([FromForm] int id)
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
            return Ok(await grupoRepository.GetGrupo(id));
        }
        [HttpPut]
        public async Task<IActionResult> Put([FromForm] DTOInsertGrupo grupo)
        {
            DAOGrupo dAOGrupo = new DAOGrupo();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (grupo.FotoURL != null)
            {
                dAOGrupo.FotoURL = await ImageUtility.CrearImagen(grupo.FotoURL, "FotosDeGrupos", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
            }
            dAOGrupo.IdGrupo = grupo.IdGrupo;
            dAOGrupo.IdFinca = grupo.IdFinca;
            dAOGrupo.Nombre = grupo.Nombre;
            return Ok(await grupoRepository.UpdateGrupo(dAOGrupo));
        }
    }
}
