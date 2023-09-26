using Models.DTO;
using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    //public interface IUsuarioRepository
    public interface IUsuarioRepository : IData<Usuario>
    {
        //void InsertarUsuario(Usuario usuario);
        Task<Usuario> VerificarUsuario(string nombreUsuario, string contraseña);
        //Task ActualizarUsuario(Usuario usuario);
        Task CambiarEstado(int idUsuario, bool estado);

    }
}
