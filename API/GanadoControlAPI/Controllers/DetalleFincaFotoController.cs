using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleFincaFotoController : ControllerBase
    {
        IDetalleFincaFotoRepository detalleFincaFotoRepository = new DetalleFincaFotoData();
        [HttpPost]
        public async Task<IActionResult> Insertar([FromBody] DetalleFincaFoto detalleFincaFoto)
        {

            await detalleFincaFotoRepository.Insertar(detalleFincaFoto);
            return Created("Creado", true);
        }
    }
}
