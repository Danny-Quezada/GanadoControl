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

        [HttpGet("Ganado/{idGanado}")]
        public async Task<IActionResult> GetRecordatorioPorGanado(string idGanado)
        {
            return Ok(await recordatorioRepository.ObtenerRecordatoriosPorGanado(idGanado));
        }

        [HttpPost]
        public IActionResult Post([FromForm] Recordatorio recordatorio)
        {
            recordatorioRepository.Insertar(recordatorio);
            return Created("Creado", true);
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await recordatorioRepository.EliminarRecordatorio(id);
            return NoContent();
        }
        [HttpPut("{id}")]
        public async Task<IActionResult> Update([FromBody] Recordatorio recordatorio, int id)
        {
            recordatorio.Id = id;
            await recordatorioRepository.ActualizarRecordatorio(recordatorio);
            return Ok("Actualizado correctamente");
        }
    }
}
