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
    public class DetalleGanadoData : IDetalleGanadoRepository
    {
        private readonly string CadenaConexion;
        public DetalleGanadoData(string CadenaConexion)
        {
            this.CadenaConexion = CadenaConexion;
        }
        public async Task Insertar(DetalleGanado data)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarDetalleGanado", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdGanado", SqlDbType.VarChar,30)).Value = data.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@FotoURL", SqlDbType.VarChar, 100)).Value = data.FotoURL;

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
