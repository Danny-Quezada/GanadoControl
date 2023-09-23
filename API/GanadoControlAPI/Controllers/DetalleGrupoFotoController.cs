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
        IDetalleGrupoFotoRepository detalleGrupoFotoRepository = new DetalleGrupoFotoData();

        [HttpPost]
        public async Task<IActionResult> Insertar([FromBody] DetalleGrupoFoto detalleGrupoFoto)
        {

            await detalleGrupoFotoRepository.Insertar(detalleGrupoFoto);
            return Created("Creado", true);
        }
    }
}
