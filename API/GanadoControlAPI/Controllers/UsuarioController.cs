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
        IUsuarioRepository usuarioRepository = new UsuarioData();
        [HttpPost]
        public IActionResult InsertarUsuario([FromBody]Usuario usuario)
        {
            //usuarioRepository.InsertarUsuario(usuario);
            usuarioRepository.Insertar(usuario);
            return Created("Creado", true);
        }
        [HttpGet(("verificar/{nombreUsuario}, {contraseña}"))]
        public IActionResult VerificarUsuario(string nombreUsuario, string contraseña)
        {
            return Ok(usuarioRepository.VerificarUsuario(nombreUsuario, contraseña));
        }
    }
}
