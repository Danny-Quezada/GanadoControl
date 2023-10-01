using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleFincaController : ControllerBase
    {
        public DetalleFincaController(IDetalleFincaRepository detalleFinca)
        {
            detalleFincaRepository = detalleFinca;
        }
        IDetalleFincaRepository detalleFincaRepository;
        [HttpPost]
        public async Task<IActionResult> InsertarDetalleFinca([FromForm] DetalleFinca detallefinca)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(detallefinca is null)
            {
                return BadRequest("El objeto DetalleFinca es nulo");
            }
            try
            {
                await detalleFincaRepository.Insertar(detallefinca);
                return Created("Creado", true);
            }
            catch (Exception ex) { return StatusCode(500, $"Error al insertar detalle finca: {ex.Message}"); }
        }
    }
}
