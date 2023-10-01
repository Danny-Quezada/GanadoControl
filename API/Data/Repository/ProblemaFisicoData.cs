using Models.Entities;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Repository
{
    public class ProblemaFisicoData : IProblemaFisicoRepository
    {
        private readonly string cadenaConexion;

        public ProblemaFisicoData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task<bool> ActualizarProblemaFisico(ProblemaFisico problemaFisico)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspActualizarProblemaFisico", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idProblema", SqlDbType.Int)).Value = problemaFisico.Id;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = problemaFisico.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@nombreParte", SqlDbType.VarChar, 30)).Value = problemaFisico.NombreParte;
                cmd.Parameters.Add(new SqlParameter("@descripcion", SqlDbType.VarChar, 100)).Value = problemaFisico.Descripcion;
                try
                {
                    await conexion.OpenAsync();
                    return (await cmd.ExecuteNonQueryAsync()) > 0;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<bool> EliminarProblemaFisico(int idProblemaFisico)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspEliminarProblemaFisico", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idProblemaFisico", SqlDbType.Int)).Value = idProblemaFisico;
                try
                {
                    await conexion.OpenAsync();
                    return (await cmd.ExecuteNonQueryAsync()) > 0;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<int> Insertar(ProblemaFisico data)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarProblemaFisico", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = data.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@nombreParte", SqlDbType.VarChar, 30)).Value = data.NombreParte;
                cmd.Parameters.Add(new SqlParameter("@descripcion", SqlDbType.VarChar, 100)).Value = data.Descripcion;
                try
                {
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

        public async Task<List<ProblemaFisico>> ObtenerProblemasFisicosPorGanado(string idGanado)
        {
            List<ProblemaFisico> listaProblemaFisico = new List<ProblemaFisico>();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspObtenerProblemaFisicoPorGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = idGanado;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            listaProblemaFisico.Add(new ProblemaFisico()
                            {
                                Id = Convert.ToInt32(dr["IdProblemaFisico"]),
                                IdGanado = dr["IdGanado"].ToString(),
                                NombreParte = dr["NombreParte"].ToString(),
                                Descripcion = dr["Descripcion"].ToString(),
                                
                            });
                        }
                    }
                    return listaProblemaFisico;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
