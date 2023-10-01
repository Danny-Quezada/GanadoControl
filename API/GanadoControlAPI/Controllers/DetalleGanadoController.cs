using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleGanadoController:ControllerBase
    {
        public DetalleGanadoController(IDetalleGanadoRepository detalleGanadoRepository)
        {
            this.detalleGanadoRepository = detalleGanadoRepository;
        }
        IDetalleGanadoRepository detalleGanadoRepository;
        [HttpPost]
        public async Task<IActionResult> Insertar([FromForm] DetalleGanado detalleGanado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (detalleGanado is null)
            {
                return BadRequest("El objeto DetalleGanado es nulo");
            }
            try
            {
                await detalleGanadoRepository.Insertar(detalleGanado);
                return Created("Creado", true);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar detalle de ganado: {ex.Message}");
            }
        }
        
    }
}
