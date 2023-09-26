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
            await partoRepository.Insertar(parto);
            return Created("Creado", true);
        }
    }
}
