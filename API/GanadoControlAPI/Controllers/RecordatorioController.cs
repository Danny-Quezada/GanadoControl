using Data.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecordatorioController : ControllerBase
    {
        private readonly IRecordatorioRepository recordatorioRepository;

        public RecordatorioController(IRecordatorioRepository recordatorioRepository)
        {
            this.recordatorioRepository = recordatorioRepository;
        }

        [HttpGet("Ganado")]
        public async Task<IActionResult> GetRecordatorioPorGanado(string idGanado)
        {
            try
            {
                return Ok(await recordatorioRepository.ObtenerRecordatoriosPorGanado(idGanado));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromForm] Recordatorio recordatorio)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(recordatorio is null)
            {
                return BadRequest("El objeto Recordatorio es nulo");  
            }
            try
            {
                return Ok(await recordatorioRepository.Insertar(recordatorio));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar recordatorio: {ex.Message}");
            }
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                return Ok(await recordatorioRepository.EliminarRecordatorio(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPut("{id}")]
        public async Task<IActionResult> Update([FromBody] Recordatorio recordatorio, [FromForm] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(recordatorio is null)
            {
                return BadRequest("El objeto Recordatorio es nulo");
            }
            try
            {
                recordatorio.Id = id;
                return Ok(await recordatorioRepository.ActualizarRecordatorio(recordatorio));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
