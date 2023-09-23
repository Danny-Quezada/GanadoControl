using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GrupoController:ControllerBase
    {
        IGrupoRepository grupoRepository = new GrupoData();
        [HttpPost]
        public async Task<IActionResult> InsertarGrupo([FromBody] Grupo grupo)
        {
            await grupoRepository.Insertar(grupo);
            return Created("Creado", true);
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await grupoRepository.GetAll());
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await grupoRepository.GetGrupo(id));
        }
    }
}
