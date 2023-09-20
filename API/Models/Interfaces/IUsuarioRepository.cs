using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    //public interface IUsuarioRepository
    public interface IUsuarioRepository : IRepository<Usuario>
    {
        //void InsertarUsuario(Usuario usuario);
        Usuario VerificarUsuario(string nombreUsuario, string contraseña);
    }
}
