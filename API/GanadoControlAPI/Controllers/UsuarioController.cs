using Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Models.Entities;
using Models.Interfaces;

namespace GanadoControlAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioRepository usuarioRepository;

        public UsuarioController(IUsuarioRepository usuarioRepository)
        {
            this.usuarioRepository = usuarioRepository;
        }

        [HttpPost]
        public IActionResult InsertarUsuario([FromForm]Usuario usuario)
        {
            //usuarioRepository.InsertarUsuario(usuario);
            usuarioRepository.Insertar(usuario);
            return Created("Creado", true);
        }
        [HttpGet(("verificar/{nombreUsuario}, {contraseña}"))]
        public async Task<IActionResult> VerificarUsuario([FromForm]string nombreUsuario, [FromForm]string contraseña)
        {
            return Ok(await usuarioRepository.VerificarUsuario(nombreUsuario, contraseña));
        }
        [HttpPut("estado/{id}, {estado}")]
        public async Task<IActionResult> CambiarEstado([FromForm]int id, [FromForm] bool estado)
        {
            await usuarioRepository.CambiarEstado(id, estado);
            return Ok("Estado actualizado correctamentes");
        }
    }
}
