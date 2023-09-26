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
            return Ok(await tratamientoRepository.ObtenerTratamientosPorUsuario(idUsuario));
        }

        [HttpPost]
        public IActionResult Post([FromForm] Tratamiento tratamiento)
        {
            tratamientoRepository.Insertar(tratamiento);
            return Created("Creado", true);
        }
        [HttpGet("Ganado/{idGanado}")]
        public async Task<IActionResult> ObtenerTratamientoPorGanado( string Ganado)
        {
            return Ok(await tratamientoRepository.ObtenerTratamientoPorGanado(Ganado));
        }
        [HttpGet("Grupo/{idGrupo}")]
        public async Task<IActionResult> ObtenerTratamientoPorGrupo(int idGrupo)
        {
            return Ok(await tratamientoRepository.ObtenerTratamientoPorGrupo(idGrupo));
        }
        [HttpGet("Finca/{idFinca}")]
        public async Task<IActionResult> ObtenerTratamientoPorFinca(int idFinca)
        {
            return Ok(await tratamientoRepository.ObtenerTratamientoPorFinca(idFinca));
        }
    }
}
