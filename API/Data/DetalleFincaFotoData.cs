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
    public class DetalleFincaFotoData : IDetalleFincaFotoRepository
    {
        private readonly string CadenaConexion;
        public DetalleFincaFotoData(string CadenaConexion)
        {
            this.CadenaConexion = CadenaConexion;
        }
        public async Task Insertar(DetalleFincaFoto data)
        {
            var webRootPath = AppDomain.CurrentDomain.BaseDirectory;
       
            using (SqlConnection conexion = new SqlConnection(CadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarDetalleFincaFoto", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = data.IdFinca;
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
