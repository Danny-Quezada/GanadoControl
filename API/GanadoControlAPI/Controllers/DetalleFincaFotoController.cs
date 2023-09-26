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

            await detalleFincaFotoRepository.Insertar(detalleFincaFoto);
            return Created("Creado", true);
        }
       
    }
}
