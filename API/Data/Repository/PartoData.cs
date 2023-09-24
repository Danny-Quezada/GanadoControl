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
    public class PartoData : IPartoRepository
    {
        private readonly string cadenaConexion;

        public PartoData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task Insertar(Parto data)
        {
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
