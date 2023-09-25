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
    public class DetalleFincaData : IDetalleFincaRepository
    {
        private readonly string CadenaConexion;
        public DetalleFincaData(string CadenaConexion)
        {
            this.CadenaConexion = CadenaConexion;
        }
        public async Task Insertar(DetalleFinca data)
        {
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarDetalleFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = data.IdFinca;
                cmd.Parameters.Add(new SqlParameter("@IdUsuario", SqlDbType.Int)).Value = data.IdUsuario;
                cmd.Parameters.Add(new SqlParameter("@Fecha", SqlDbType.Date)).Value = data.Fecha;

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
