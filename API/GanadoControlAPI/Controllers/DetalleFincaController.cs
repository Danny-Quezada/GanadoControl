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
        IDetalleFincaRepository detalleFincaRepository = new DetalleFincaData();
        [HttpPost]
        public async Task<IActionResult> InsertarDetalleFinca([FromBody] DetalleFinca detallefinca)
        {

            await detalleFincaRepository.Insertar(detallefinca);
            return Created("Creado", true);
        }
    }
}
