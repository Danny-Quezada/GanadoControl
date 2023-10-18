using Models.Entities;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.DTO;

namespace Data.Repository
{
    public class PartoData : IPartoRepository
    {
        private readonly string cadenaConexion;

        public PartoData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task<bool> EliminarParto(int id)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspEliminarParto", conexion);
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
        public async Task<DTOGrafParto> GrafParto(DateTime fechainicial, DateTime fechafinal)
        {
            DTOGrafParto dTOGraf = new DTOGrafParto();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspGrafPartos", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@fechainicial", SqlDbType.Date)).Value = fechainicial;
                cmd.Parameters.Add(new SqlParameter("@fechafinal", SqlDbType.Date)).Value = fechafinal;
                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    while (dr.Read())
                    {

                        dTOGraf = new DTOGrafParto()
                        {
                            Exitoso = Convert.ToInt32(dr["Exitoso"]) == 1 ? Convert.ToInt32(dr["cantidad"]) : dTOGraf.Exitoso,
                            NoExitoso = Convert.ToInt32(dr["Exitoso"]) == 0 ? Convert.ToInt32(dr["cantidad"]) : dTOGraf.NoExitoso,
                        };

                    }

                    return dTOGraf;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
        public async Task<int> Insertar(Parto data)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarParto", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = data.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@tipo", SqlDbType.VarChar, 30)).Value = data.Tipo;
                cmd.Parameters.Add(new SqlParameter("@exitoso", SqlDbType.Bit)).Value = data.Exitoso;
                cmd.Parameters.Add(new SqlParameter("@fecha", SqlDbType.Date)).Value = data.Fecha;
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
    }
}
