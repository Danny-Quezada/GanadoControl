using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GanadoController : ControllerBase
    {
        IGanadoRepository ganadoRepository = new GanadoData();
        [HttpPost]
        public async Task<IActionResult> InsertarGanado(Ganado ganado)
        {
            //usuarioRepository.InsertarUsuario(usuario);
            await ganadoRepository.Insertar(ganado);
            return Created("Creado", true);
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await ganadoRepository.GetAllGanado());
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetGanado(string id)
        {
            return Ok(await ganadoRepository.GetGanado(id));
        }
    }
}
