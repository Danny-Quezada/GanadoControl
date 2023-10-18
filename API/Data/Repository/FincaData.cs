using Models.DTO;
using Models.Entities;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repository
{
    public class FincaData : IFincaRepository
    {
        private readonly string CadenaConexion;
        public FincaData(string CadenaConexion)
        {
            this.CadenaConexion = CadenaConexion;
        }

        public async Task<bool> EliminarFinca(int id)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspEliminarFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = id;
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

        public async Task<List<DAOFinca>> GetAllFincaByUsuario(int IdUsuario)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGetAllFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdUsuario", SqlDbType.Int)).Value = IdUsuario;
                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    List<DAOFinca> fincas = new List<DAOFinca>();
                    while (dr.Read())
                    {

                        DAOFinca gando = new DAOFinca()
                        {
                            IdFinca = Convert.ToInt32(dr["IdFinca"]),
                            Grupos = Convert.ToInt32(dr["Grupos"]),
                            Ubicacion = dr["Ubicacion"].ToString(),
                            Hectareas = dr.GetFieldType("Hectareas") == typeof(int) ? (float)Convert.ToInt32(dr["IdFinca"]) : dr.GetFloat("Hectareas"),
                            FotoURL = dr["FotoURL"].ToString(),
                            Nombre = dr["Nombre"].ToString(),
                            NombreDueño = dr["NombreDueño"].ToString(),
                            RolUsuario = dr["RolUsuario"].ToString()
                        };

                        fincas.Add(gando);
                    }

                    return fincas;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<DAOFinca> GetFinca(int Id)
        {
            DAOFinca finca = new DAOFinca();
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGetFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).Value = Id;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            finca = new DAOFinca()
                            {

                                IdFinca = Convert.ToInt32(dr["IdFinca"]),
                                Nombre = dr["Nombre"].ToString(),
                                Ubicacion = dr["Ubicacion"].ToString(),
                                Hectareas = (float)dr["Hectareas"],
                                NombreDueño = dr["NombreDueño"].ToString(),
                                FotoURL = dr["FotoURL"].ToString(),
                            };
                        }
                    }
                    return finca;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<int> Insertar(Finca finca)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar, 50)).Value = finca.Nombre;
                cmd.Parameters.Add(new SqlParameter("@Ubicacion", SqlDbType.VarChar, 100)).Value = finca.Ubicacion;
                cmd.Parameters.Add(new SqlParameter("@Hectareas", SqlDbType.Float, 2)).Value = finca.Hectareas;
                cmd.Parameters.Add(new SqlParameter("@NombreDueño", SqlDbType.VarChar, 50)).Value = finca.NombreDueño;
                SqlCommand cmd1 = new SqlCommand("uspUltimoIdFinca", conexion);
                try
                {
                    await conexion.OpenAsync();
                    await cmd.ExecuteScalarAsync();
                    ultimoId = Convert.ToInt32(await cmd1.ExecuteScalarAsync());
                    return ultimoId;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<string> InvitarAFinca(int idFinca, int idUsuario, string rol)
        {
            string token;
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInvitarAFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idFinca", SqlDbType.Int)).Value = idFinca;
                cmd.Parameters.Add(new SqlParameter("@idUsuarioCreador", SqlDbType.Int)).Value = idUsuario;
                cmd.Parameters.Add(new SqlParameter("@rolAsignado", SqlDbType.VarChar, 50)).Value = rol;
                try
                {
                    await conexion.OpenAsync();
                    token = (await cmd.ExecuteScalarAsync()).ToString();
                    return token;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<bool> UpdateFinca(DAOFinca DAOFinca)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspUpdateFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = DAOFinca.IdFinca;
                cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar, 50)).Value = DAOFinca.Nombre;
                cmd.Parameters.Add(new SqlParameter("@Ubicacion", SqlDbType.VarChar, 100)).Value = DAOFinca.Ubicacion;
                cmd.Parameters.Add(new SqlParameter("@Hectareas", SqlDbType.Float, 2)).Value = DAOFinca.Hectareas;
                cmd.Parameters.Add(new SqlParameter("@NombreDueño", SqlDbType.VarChar, 50)).Value = DAOFinca.NombreDueño;
                cmd.Parameters.Add(new SqlParameter("@FotoURL", SqlDbType.VarChar, 100)).Value = DAOFinca.FotoURL;

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

        public async Task<int> VerificarInvitacion(string token, int idUsuario)
        {
            int idFinca;
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspVerificarInvitacion", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@token", SqlDbType.VarChar, 255)).Value = token;
                cmd.Parameters.Add(new SqlParameter("@idUsuarioInvitado", SqlDbType.Int)).Value = idUsuario;
                try
                {
                    await conexion.OpenAsync();
                    idFinca = Convert.ToInt32(await cmd.ExecuteScalarAsync());
                    return idFinca;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
