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
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if(usuario is null)
            {
                return BadRequest("El objeto Usuario es nulo");
            }
            try
            {
                return Ok(await usuarioRepository.Insertar(usuario));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Ocurrió un error al insertar usuario: {ex.Message}");
            }
        }
        [HttpGet(("verificar/{nombreUsuario}, {contraseña}"))]
        public async Task<IActionResult> VerificarUsuario(string nombreUsuario, string contraseña)
        {
            try
            {
                return Ok(await usuarioRepository.VerificarUsuario(nombreUsuario, contraseña));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPut("estado/{id}, {estado}")]
        public async Task<IActionResult> CambiarEstado(int id,  bool estado)
        {
            try
            {
                return Ok(await usuarioRepository.CambiarEstado(id, estado));
            }
            catch (Exception ex) { return StatusCode(500, ex.Message); }
        }
    }
}
