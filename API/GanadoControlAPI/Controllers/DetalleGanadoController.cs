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
        IDetalleGanadoRepository detalleGanadoRepository = new DetalleGanadoData();
        [HttpPost]
        public async Task<IActionResult> Insertar([FromBody] DetalleGanado detalleGanado)
        {

            await detalleGanadoRepository.Insertar(detalleGanado);
            return Created("Creado", true);
        }
    }
}
