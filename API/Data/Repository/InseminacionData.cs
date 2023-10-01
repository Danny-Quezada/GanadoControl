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
    public class InseminacionData : IInseminacionRepository
    {
        private readonly string cadenaConexion;

        public InseminacionData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task<bool> EliminarInseminacion(int id)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspEliminarInseminacion", conexion);
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

        public async Task<int> Insertar(Inseminacion data)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarInseminacion", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = data.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@fecha", SqlDbType.Date)).Value = data.FechaInseminacion;
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
