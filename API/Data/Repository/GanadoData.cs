using Models.DTO;
using Models.Entities;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repository
{
    public class GanadoData : IGanadoRepository
    {
        private readonly string CadenaConexion;
        public GanadoData(string CadenaConexion)
        {
            this.CadenaConexion = CadenaConexion;
        }
        public async Task<List<DAOGanado>> GetAllGanadoByGrupo(int IdGrupo)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGetAllGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdGrupo", SqlDbType.Int)).Value = IdGrupo;
                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    List<DAOGanado> ganados = new List<DAOGanado>();
                    while (dr.Read())
                    {

                        DAOGanado gando = new DAOGanado()
                        {
                            IdGanado = dr["IdGanado"].ToString(),
                            Tipo = dr["Tipo"].ToString(),
                            UltimaVacuna = Convert.ToDateTime(dr["UltimaVacuna"] == DBNull.Value ? null : dr["UltimaVacuna"]),
                            Ultimadesparacitacion = Convert.ToDateTime(dr["UltimaDesparacitación"] == DBNull.Value ? null : dr["UltimaDesparacitación"]),
                            Peso = (float)dr["Peso"],
                            FechaNacimiento = Convert.ToDateTime(dr["fechanacimiento"]),
                            Raza = dr["Raza"] == null ? null : dr["Raza"].ToString(),
                            FotoURL = dr["FotoURL"].ToString(),
                            IdMadre = dr["IdMadre"] == null ? null : dr["IdMadre"].ToString(),
                            IdPadre = dr["IdPadre"] == null ? null : dr["IdPadre"].ToString(),
                            Estado = dr["Estado"].ToString(),
                            IdGrupo = Convert.ToInt32(dr["IdGrupo"]),
                        };

                        ganados.Add(gando);
                    }

                    return ganados;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<DAOGanado> GetGanado(string id)
        {
            DAOGanado ganado = new DAOGanado();
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGetGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.VarChar, 30)).Value = id;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            ganado = new DAOGanado()

                            {
                                IdGanado = dr["IdGanado"].ToString(),
                                Raza = dr["Raza"].ToString(),
                                Peso = (float)dr["Peso"],
                                FechaNacimiento = Convert.ToDateTime(dr["FechaNacimiento"]),
                                Tipo = dr["Tipo"].ToString(),
                                IdMadre = dr["IdMadre"] == DBNull.Value ? null : dr["IdMadre"].ToString(),
                                IdPadre = dr["IdPadre"] == DBNull.Value ? null : dr["IdPadre"].ToString(),
                                IdGrupo = Convert.ToInt32(dr["IdGrupo"]),
                                UltimaVacuna = Convert.ToDateTime(dr["UltimaVacuna"] == DBNull.Value ? null : dr["UltimaVacuna"]),
                                Ultimadesparacitacion = Convert.ToDateTime(dr["UltimaDesparacitación"] == DBNull.Value ? null : dr["UltimaDesparacitación"]),
                                Estado = dr["Estado"].ToString(),
                                FotoURL = dr["FotoURL"].ToString(),
                            };
                        }
                    }
                    return ganado;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
        public async Task<DTOGrafVacunas> GrafVacunas(int IdGrupo)
        {
            DTOGrafVacunas dTO = new DTOGrafVacunas();
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGrafVacunacion", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdGrupo", SqlDbType.Int)).Value = IdGrupo;
                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    while (dr.Read())
                    {
                        dTO.NoVacunadosT = dr["Tipo"].ToString() == "Toro" ? Convert.ToInt32(dr["NoVacunados"]) : dTO.NoVacunadosT;
                        dTO.NoVacunadosV = dr["Tipo"].ToString() == "Vaca" ? Convert.ToInt32(dr["NoVacunados"]) : dTO.NoVacunadosV;
                    }

                    return dTO;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task Insertar(Ganado ganado)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Peso", SqlDbType.Real)).Value = ganado.Peso;
                cmd.Parameters.Add(new SqlParameter("@Raza", SqlDbType.VarChar, 40)).Value = ganado.Raza;
                cmd.Parameters.Add(new SqlParameter("@FechaNacimiento", SqlDbType.DateTime)).Value = ganado.FechaNacimiento == null ? DBNull.Value : ganado.FechaNacimiento;
                cmd.Parameters.Add(new SqlParameter("@Tipo", SqlDbType.VarChar, 30)).Value = ganado.Tipo;
                cmd.Parameters.Add(new SqlParameter("@Idpadre", SqlDbType.VarChar, 30)).Value = ganado.IdPadre == null ? DBNull.Value : ganado.IdPadre;
                cmd.Parameters.Add(new SqlParameter("@IdMadre", SqlDbType.VarChar, 30)).Value = ganado.IdMadre == null ? DBNull.Value : ganado.IdMadre;
                cmd.Parameters.Add(new SqlParameter("@IdGrupo", SqlDbType.Int)).Value = ganado.IdGrupo;
                cmd.Parameters.Add(new SqlParameter("@IdGanado", SqlDbType.VarChar, 30)).Value = ganado.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@Estado", SqlDbType.VarChar, 30)).Value = ganado.Estado;
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

        public async Task<bool> UpdateGanado(DAOGanado ganado)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspUpdateGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Peso", SqlDbType.Real)).Value = ganado.Peso;
                cmd.Parameters.Add(new SqlParameter("@Raza", SqlDbType.VarChar, 40)).Value = ganado.Raza;
                cmd.Parameters.Add(new SqlParameter("@FechaNacimiento", SqlDbType.DateTime)).Value = ganado.FechaNacimiento == null ? DBNull.Value : ganado.FechaNacimiento;
                cmd.Parameters.Add(new SqlParameter("@Tipo", SqlDbType.VarChar, 30)).Value = ganado.Tipo;
                cmd.Parameters.Add(new SqlParameter("@Idpadre", SqlDbType.VarChar, 30)).Value = ganado.IdPadre == null ? DBNull.Value : ganado.IdPadre;
                cmd.Parameters.Add(new SqlParameter("@IdMadre", SqlDbType.VarChar, 30)).Value = ganado.IdMadre == null ? DBNull.Value : ganado.IdMadre;
                cmd.Parameters.Add(new SqlParameter("@IdGrupo", SqlDbType.Int)).Value = ganado.IdGrupo;
                cmd.Parameters.Add(new SqlParameter("@IdGanado", SqlDbType.VarChar, 30)).Value = ganado.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@Estado", SqlDbType.VarChar, 30)).Value = ganado.Estado;
                cmd.Parameters.Add(new SqlParameter("@FotoURL", SqlDbType.VarChar, 100)).Value = ganado.FotoURL;

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
    }
}
