using Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TratamientoController : ControllerBase
    {
        private readonly ITratamientoRepository tratamientoRepository;

        public TratamientoController(ITratamientoRepository tratamientoRepository)
        {
            this.tratamientoRepository = tratamientoRepository;
        }

        [HttpGet("Usuario/{idUsuario}")]
        public async Task<IActionResult> GetTratamientosPorGanado( int idUsuario)
        {
            try
            {
                return Ok(await tratamientoRepository.ObtenerTratamientosPorUsuario(idUsuario));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromForm] Tratamiento tratamiento)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(tratamiento is null)
            {
                return BadRequest("El objeto Tratamiento es nulo");
            }
            try
            {
                await tratamientoRepository.Insertar(tratamiento);
                return Created("Creado", true);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar tratamiento: {ex.Message}");
            }
        }
        [HttpGet("Ganado/{idGanado}")]
        public async Task<IActionResult> ObtenerTratamientoPorGanado([FromForm] string Ganado)
        {
            try
            {
                return Ok(await tratamientoRepository.ObtenerTratamientoPorGanado(Ganado));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("Grupo/{idGrupo}")]
        public async Task<IActionResult> ObtenerTratamientoPorGrupo([FromForm] int idGrupo)
        {
            try
            {
                return Ok(await tratamientoRepository.ObtenerTratamientoPorGrupo(idGrupo));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("Finca/{idFinca}")]
        public async Task<IActionResult> ObtenerTratamientoPorFinca([FromForm] int idFinca)
        {
            try
            {
                return Ok(await tratamientoRepository.ObtenerTratamientoPorFinca(idFinca));
            }
            catch (Exception ex) { return StatusCode(500, ex.Message); }
        }
    }
}
