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
        public async Task<IActionResult> InsertarUsuario([FromForm]Usuario usuario)
        {
            return Ok(await usuarioRepository.Insertar(usuario));
        }
        [HttpGet(("verificar/{nombreUsuario}, {contraseña}"))]
        public async Task<IActionResult> VerificarUsuario(string nombreUsuario, string contraseña)
        {
            return Ok(await usuarioRepository.VerificarUsuario(nombreUsuario, contraseña));
        }
        [HttpPut("estado/{id}, {estado}")]
        public async Task<IActionResult> CambiarEstado(int id,  bool estado)
        {
            return Ok(await usuarioRepository.CambiarEstado(id, estado));
        }
    }
}
