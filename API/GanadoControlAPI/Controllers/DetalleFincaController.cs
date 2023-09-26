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

            await detalleFincaRepository.Insertar(detallefinca);
            return Created("Creado", true);
        }
    }
}
