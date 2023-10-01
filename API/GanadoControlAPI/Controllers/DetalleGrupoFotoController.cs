using Data;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleGrupoFotoController:ControllerBase
    {
        public DetalleGrupoFotoController(IDetalleGrupoFotoRepository detalleGrupoFoto)
        {
            this.detalleGrupoFotoRepository = detalleGrupoFoto;
        }
        IDetalleGrupoFotoRepository detalleGrupoFotoRepository;

        [HttpPost]
        public async Task<IActionResult> Insertar([FromForm] DetalleGrupoFoto detalleGrupoFoto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (detalleGrupoFoto is null)
            {
                return BadRequest("El objeto DetalleGrupoFoto es nulo");
            }
            try
            {
                await detalleGrupoFotoRepository.Insertar(detalleGrupoFoto);
                return Created("Creado", true);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al insertar foto del grupo: {ex.Message}");
            }
        }
    }
}
