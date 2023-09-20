using Models.Entities;
using Models.Interfaces;
using System.Data.SqlClient;
using System.Data;

namespace Data
{
    public class UsuarioData : IUsuarioRepository
    {
        //public void InsertarUsuario(Usuario usuario)
        public void Insertar(Usuario usuario)
        {
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspIngresarUsuario", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@correo", SqlDbType.VarChar, 200)).Value = usuario.Correo;
                cmd.Parameters.Add(new SqlParameter("@contraseña", SqlDbType.VarChar, 200)).Value = usuario.Contraseña;
                cmd.Parameters.Add(new SqlParameter("@rol", SqlDbType.VarChar, 30)).Value = usuario.Rol;
                cmd.Parameters.Add(new SqlParameter("@nombreUsuario", SqlDbType.VarChar, 30)).Value = usuario.NombreUsuario;
                try
                {
                    conexion.Open();
                    cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public Usuario VerificarUsuario(string nombreUsuario, string contraseña)
        {
            Usuario usuario=new Usuario();
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspValidarIngreso", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@nombreUsuario", SqlDbType.VarChar, 30)).Value = nombreUsuario;
                cmd.Parameters.Add(new SqlParameter("@contraseña", SqlDbType.VarChar, 200)).Value = contraseña;
                try
                {
                    conexion.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            usuario = new Usuario()
                            {
                                Id = Convert.ToInt32(dr["IdUsuario"]),
                                Rol = dr["Rol"].ToString(),
                            };
                        }
                    }
                    return usuario;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}