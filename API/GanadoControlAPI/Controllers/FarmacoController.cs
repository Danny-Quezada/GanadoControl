using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FarmacoController : ControllerBase
    {
        private readonly IFarmacoRepository farmacoRepository;

        public FarmacoController(IFarmacoRepository farmacoRepository)
        {
            this.farmacoRepository = farmacoRepository;
        }

        [HttpGet("finca/{idFinca}")]
        public async Task<IActionResult> GetFarmacos(int idFinca)
        {
            return Ok(await farmacoRepository.ObtenerFarmacosPorFinca(idFinca));
        }

        [HttpPost]
        public IActionResult Post([FromForm] Farmaco farmaco)
        {
            farmacoRepository.Insertar(farmaco);
            return Created("Creado", true);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put([FromForm] Farmaco farmaco, int id)
        {
            farmaco.Id = id;
            await farmacoRepository.ActualizarFarmaco(farmaco);
            return Ok("Actualizado correctamente");
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await farmacoRepository.EliminarFarmaco(id);
            return NoContent();
        }
    }
}
