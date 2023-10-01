using Data;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleFincaFotoController : ControllerBase
    {
        public DetalleFincaFotoController(IDetalleFincaFotoRepository detalleFincaFoto)
        {
            this.detalleFincaFotoRepository = detalleFincaFoto;
        }
        IDetalleFincaFotoRepository detalleFincaFotoRepository;
        [HttpPost]
        public async Task<IActionResult> Insertar([FromForm] DetalleFincaFoto detalleFincaFoto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (detalleFincaFoto is null)
            {
                return BadRequest("El objeto DetalleFincaFoto es nulo");
            }
            try
            {
                await detalleFincaFotoRepository.Insertar(detalleFincaFoto);
                return Created("Creado", true);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar foto de finca: {ex.Message}");
            }
        }
       
    }
}
