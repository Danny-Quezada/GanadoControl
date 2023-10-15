using Models.Entities;
using Models.Interfaces;
using System.Data.SqlClient;
using System.Data;
using Models.DTO;

namespace Data.Repository
{
    public class UsuarioData : IUsuarioRepository
    {
        private readonly string cadenaConexion;
        public UsuarioData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task<bool> ActualizarUsuario(int idUsuario, string nombreUsuario, string contraseñaActual, string? nuevaContraseña)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspActualizarUsuario", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idUsuario", SqlDbType.Int)).Value = idUsuario;
                cmd.Parameters.Add(new SqlParameter("@contraseñaNueva", SqlDbType.VarChar, 255)).Value = nuevaContraseña == null ? DBNull.Value : nuevaContraseña;
                cmd.Parameters.Add(new SqlParameter("@contraseñaVieja", SqlDbType.VarChar, 255)).Value = contraseñaActual;
                cmd.Parameters.Add(new SqlParameter("@nombreUsuario", SqlDbType.VarChar, 50)).Value = nombreUsuario;
                try
                {
                    await conexion.OpenAsync();
                    return await cmd.ExecuteNonQueryAsync() > 0;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<bool> CambiarEstado(int idUsuario, bool estado)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspCambiarEstadoUsuario", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idUsuario", SqlDbType.Int)).Value = idUsuario;
                cmd.Parameters.Add(new SqlParameter("@estado", SqlDbType.Bit)).Value = estado;
                try
                {
                    await conexion.OpenAsync();
                    return await cmd.ExecuteNonQueryAsync() > 0;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        //public void InsertarUsuario(Usuario usuario)
        public async Task<int> Insertar(Usuario usuario)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspIngresarUsuario", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@correo", SqlDbType.VarChar, 200)).Value = usuario.Correo;
                cmd.Parameters.Add(new SqlParameter("@contraseña", SqlDbType.VarChar, 200)).Value = usuario.Contraseña;
                cmd.Parameters.Add(new SqlParameter("@cargo", SqlDbType.VarChar, 30)).Value = usuario.Cargo;
                cmd.Parameters.Add(new SqlParameter("@nombreUsuario", SqlDbType.VarChar, 30)).Value = usuario.NombreUsuario;
                try
                {
                    await conexion.OpenAsync();
                    ultimoId = Convert.ToInt32(await cmd.ExecuteScalarAsync());
                    return ultimoId;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<DAOUsuario> VerificarUsuario(string nombreUsuario, string contraseña)
        {
            DAOUsuario usuario = new DAOUsuario();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspValidarIngreso", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@nombreUsuario", SqlDbType.VarChar, 30)).Value = nombreUsuario;
                cmd.Parameters.Add(new SqlParameter("@contraseña", SqlDbType.VarChar, 200)).Value = contraseña;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            usuario = new DAOUsuario()
                            {
                                Id = Convert.ToInt32(dr["IdUsuario"]),
                                Cargo = dr["Cargo"].ToString(),
                                NombreUsuario = dr["NombreUsuario"].ToString()
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