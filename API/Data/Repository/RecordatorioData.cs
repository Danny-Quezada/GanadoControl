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
    public class RecordatorioData : IRecordatorioRepository
    {
        private readonly string cadenaConexion;

        public RecordatorioData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task ActualizarRecordatorio(Recordatorio recordatorio)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspActualizarRecordatorio", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idrecordatorio", SqlDbType.Int)).Value = recordatorio.Id;
                cmd.Parameters.Add(new SqlParameter("@fecha", SqlDbType.Date)).Value = recordatorio.Fecha;
                cmd.Parameters.Add(new SqlParameter("@titulo", SqlDbType.VarChar, 50)).Value = recordatorio.Titulo;
                cmd.Parameters.Add(new SqlParameter("@descripcion", SqlDbType.VarChar, 100)).Value = recordatorio.Descripcion;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = recordatorio.IdGanado;
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

        public async Task EliminarRecordatorio(int idRecordatorio)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspEliminarRecordatorio", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idrecordatorio", SqlDbType.Int)).Value = idRecordatorio;
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

        public async Task Insertar(Recordatorio data)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarRecordatorio", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@fecha", SqlDbType.Date)).Value = data.Fecha;
                cmd.Parameters.Add(new SqlParameter("@titulo", SqlDbType.VarChar, 50)).Value = data.Titulo;
                cmd.Parameters.Add(new SqlParameter("@descripcion", SqlDbType.VarChar, 100)).Value = data.Descripcion;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = data.IdGanado;
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

        public async Task<List<Recordatorio>> ObtenerRecordatoriosPorGanado(string idGanado)
        {
            List<Recordatorio> listaRecordatorio = new List<Recordatorio>();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspObtenerRecordatorioPorGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = idGanado;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            listaRecordatorio.Add(new Recordatorio()
                            {
                                Id = Convert.ToInt32(dr["IdRecordatorio"]),
                                IdGanado = dr["IdGanado"].ToString(),
                                Fecha = Convert.ToDateTime(dr["Fecha"]),
                                Descripcion = dr["Descripcion"].ToString(),
                                Titulo = dr["Titulo"].ToString()
                            }); 
                        }
                    }
                    return listaRecordatorio;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
