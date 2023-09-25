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
        public async Task<IActionResult> Insertar([FromBody] DetalleGanado detalleGanado)
        {

            await detalleGanadoRepository.Insertar(detalleGanado);
            return Created("Creado", true);
        }
        
    }
}
