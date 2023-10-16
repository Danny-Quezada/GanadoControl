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
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(dtoganado is null)
            {
                return BadRequest("El objeto ganado es nulo");
            }
            try
            {
                DetalleGanado detalleGanado = new DetalleGanado();
                if (dtoganado.FotoURL != null)
                {
                    detalleGanado.FotoURL = await ImageUtility.CrearImagen(dtoganado.FotoURL, "FotosDeGanados", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString());
                }
                else
                {
                    detalleGanado.FotoURL = await ImageUtility.InsertImagen("FotosDeGanados", _webHostEnvironment.WebRootPath, HttpContext.Request.Scheme, HttpContext.Request.Host.ToString(),dtoganado.Tipo=="Vaca"?"VACA.png":"TORO.png");
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
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar ganado: {ex.Message}");
            }
        }
        [HttpGet("Grupo/Grafico/{Id}")]
        public async Task<IActionResult> GrafVacunas(int Id)
        {
            try
            {
                return Ok(await ganadoRepository.GrafVacunas(Id));
            }catch(Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
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
        public async Task<IActionResult> Put([FromForm] DTOInsertarGanado ganado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(ganado is null)
            {
                return BadRequest("El objeto ganado es nulo");  
            }
            try
            {
                DAOGanado ganado1 = new DAOGanado();
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
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
