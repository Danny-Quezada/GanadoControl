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

            await detalleGrupoFotoRepository.Insertar(detalleGrupoFoto);
            return Created("Creado", true);
        }
    }
}
