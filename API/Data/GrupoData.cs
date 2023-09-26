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

namespace Data
{
    public class GrupoData : IGrupoRepository
    {
        private readonly string CadenaConexion;
        public GrupoData(string CadenaConexion)
        {
            this.CadenaConexion = CadenaConexion;
        }
        public async Task<int> Insertar(Grupo grupo)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarGrupo", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar, 50)).Value = grupo.Nombre;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = grupo.IdFinca;

                try
                {
                    await conexion.OpenAsync();
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            ultimoId = Convert.ToInt32(dr["UltimoID"]);
                        }
                    }
                    return ultimoId;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
        public async Task<List<DAOGrupo>> GetAllByFinca(int IdFinca)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGetAllGrupos", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = IdFinca;
                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    List<DAOGrupo> grupos = new List<DAOGrupo>();
                    while (dr.Read())
                    {

                        DAOGrupo grupo = new DAOGrupo()
                        {
                            IdGrupo = Convert.ToInt32(dr["IdGrupo"]),
                            IdFinca = Convert.ToInt32(dr["IdFinca"]),
                            Nombre = dr["Nombre"].ToString(),
                            CantidadGanado = Convert.ToInt32(dr["CantidadDeGanados"]),
                            FotoURL = dr["FotoURL"].ToString()
                        };

                        grupos.Add(grupo);
                    }

                    return grupos;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<DAOGrupo> GetGrupo(int id)
        {
            DAOGrupo grupo = new DAOGrupo();
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGetGrupo", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).Value = id;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            grupo = new DAOGrupo()
                            {
                                IdGrupo = Convert.ToInt32(dr["IdGrupo"]),
                                IdFinca = Convert.ToInt32(dr["IdFinca"]),
                                Nombre = dr["Nombre"].ToString(),
                                CantidadGanado = Convert.ToInt32(dr["CantidadDeGanados"]),
                                FotoURL = dr["FotoURL"].ToString(),
                            };
                        }
                    }
                    return grupo;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<int> GetLastId()
        {
            int id = 0;
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspUltimoIdGrupo", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            id = Convert.ToInt32(dr["IdGrupo"]);
                        }

                    }
                    return id;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task UpdateGrupo(DAOGrupo grupo)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspUpdateGrupo", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar, 50)).Value = grupo.Nombre;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = grupo.IdFinca;
                cmd.Parameters.Add(new SqlParameter("@IdGrupo", SqlDbType.Int)).Value = grupo.IdGrupo;
                cmd.Parameters.Add(new SqlParameter("@FotoURL", SqlDbType.VarChar, 100)).Value = grupo.FotoURL;
                try
                {
                    await conexion.OpenAsync();
                    await cmd.ExecuteNonQueryAsync();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
