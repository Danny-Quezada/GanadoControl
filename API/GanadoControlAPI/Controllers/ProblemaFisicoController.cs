using Data.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProblemaFisicoController : ControllerBase
    {
        private readonly IProblemaFisicoRepository problemaFisicoRepository;

        public ProblemaFisicoController(IProblemaFisicoRepository problemaFisicoRepository)
        {
            this.problemaFisicoRepository = problemaFisicoRepository;
        }

        [HttpPost]
        public async Task<IActionResult> InsertarParto([FromForm] ProblemaFisico problemaFisico)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(problemaFisico is null)
            {
                return BadRequest("El objeto ProblemaFisico es nulo");
            }
            try
            {
                return Ok(await problemaFisicoRepository.Insertar(problemaFisico));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar problema físico: {ex.Message}");
            }
        }
        [HttpGet("ganado")]
        public async Task<IActionResult> ObtenerProbFisicoXGanado(string idGanado)
        {
            try
            {
                return Ok(await problemaFisicoRepository.ObtenerProblemasFisicosPorGanado(idGanado));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPut("{id}")]
        public async Task<IActionResult> ActualizarProbFisico([FromForm]ProblemaFisico problema, [FromForm]int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(problema is null)
            {
                return BadRequest("El objeto ProblemaFisico es nulo");
            }
            try
            {
                problema.Id = id;
                return Ok(await problemaFisicoRepository.ActualizarProblemaFisico(problema));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> EliminarProbFisico([FromForm]int id)
        {
            try
            {
                return Ok(await problemaFisicoRepository.EliminarProblemaFisico(id));
            }
            catch (Exception ex) { return StatusCode(500, ex.Message); }
        }
        [HttpGet("Grafico")]
        public async Task<IActionResult> GrafPartesDañadas(int IdUsuario)
        {
            try
            {
                return Ok(await problemaFisicoRepository.GrafPartesDañadas(IdUsuario));
            }
            catch (Exception ex) { return StatusCode(500, ex.Message); }
        }
    }
}
