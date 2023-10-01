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
        public GanadoController(IWebHostEnvironment _webHostEnvironment1,IGanadoRepository ganadoRepository,IDetalleGanadoRepository detalleGanadoRepository)
        {
            _webHostEnvironment = _webHostEnvironment1;
            this.ganadoRepository = ganadoRepository;
            this.detalleGanadoRepository = detalleGanadoRepository;
        }
        IGanadoRepository ganadoRepository;
        IDetalleGanadoRepository detalleGanadoRepository;
        private readonly IWebHostEnvironment _webHostEnvironment;
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
                detalleGanado.FotoURL = await ImageUtility.CrearImagen(dtoganado.FotoURL, "FotosDeGanados", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
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
                Estado = dtoganado.Estado,
            };
            await ganadoRepository.Insertar(ganado);
            detalleGanado.IdGanado = dtoganado.IdGanado;
            await detalleGanadoRepository.Insertar(detalleGanado);
            return Created("Creado", true);
        }
        [HttpGet("Grupo/{id}")]
        public async Task<IActionResult> GetAll(int id)
        {
            try
            {
                return Ok(await ganadoRepository.GetAllGanadoByGrupo(id));
            }
            catch (Exception ex) { return StatusCode(500, ex.Message); }
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetGanado(string id)
        {
            try
            {
                return Ok(await ganadoRepository.GetGanado(id));
            }
            catch (Exception ex) { return StatusCode(500, ex.Message); }
        }
        [HttpPut]
        public async Task<IActionResult> Post([FromForm] DTOInsertarGanado ganado)
        {
            DAOGanado ganado1 = new DAOGanado();
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (ganado.FotoURL != null)
            {
                ganado1.FotoURL = await ImageUtility.CrearImagen(ganado.FotoURL, "FotosDeGanados", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
            }
            ganado1.IdPadre = ganado.IdPadre;
            ganado1.IdMadre = ganado.IdMadre;
            ganado1.Peso = (float)ganado.Peso;
            ganado1.Estado = ganado.Estado;
            ganado1.IdGanado = ganado.IdGanado;
            ganado1.Tipo = ganado.Tipo;
            ganado1.FechaNacimiento = ganado.FechaNacimiento;
            ganado1.IdGrupo = ganado.IdGrupo;
            ganado1.Estado = ganado.Estado;
            ganado1.Raza = ganado.Raza;
            return Ok(await ganadoRepository.UpdateGanado(ganado1));
        }
    }
}
