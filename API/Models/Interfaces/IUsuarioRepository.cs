using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IUsuarioRepository : IData<Usuario>
    {
        Task<DAOUsuario> VerificarUsuario(string nombreUsuario, string contraseña);
        Task<bool> CambiarEstado(int idUsuario, bool estado);
        Task<bool> ActualizarUsuario(int idUsuario, string nombreUsuario ,string contraseñaActual, string? nuevaContraseña);

    }
}
