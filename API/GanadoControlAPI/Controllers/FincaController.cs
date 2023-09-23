using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FincaController : ControllerBase
    {
        IFincaRepository fincaRepository = new FincaData();
        [HttpPost]
        public async Task<IActionResult> InsertarFinca([FromBody] Finca finca)
        {

            await fincaRepository.Insertar(finca);
            return Created("Creado", true);
        }
        [HttpGet]
        public async Task<IActionResult> GetAllFinca()
        {
            return Ok(await fincaRepository.GetAllFinca());
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await fincaRepository.GetFinca(id));
        }
    }
}
