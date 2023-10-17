using Data.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PartoController : ControllerBase
    {
        private readonly IPartoRepository partoRepository;

        public PartoController(IPartoRepository partoRepository)
        {
            this.partoRepository = partoRepository;
        }

        [HttpPost]
        public async Task<IActionResult> InsertarParto([FromForm] Parto parto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(parto is null)
            {
                return BadRequest("El objeto Parto es nulo");
            }
            try
            {
                return Ok(await partoRepository.Insertar(parto));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error a la hora de insertar parto {ex.Message}");
            }
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                return Ok(await partoRepository.EliminarParto(id));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
