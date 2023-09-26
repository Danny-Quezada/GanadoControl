using Models.Entities;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using Models.DTO;

namespace Data
{
    public class TratamientoData : ITratamientoRepository
    {
        private readonly string cadenaConexion;
        public TratamientoData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }
        public async Task Insertar(Tratamiento data)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarTratamiento", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idGanado", SqlDbType.VarChar, 30)).Value = data.IdGanado;
                cmd.Parameters.Add(new SqlParameter("@idFarmaco", SqlDbType.Int)).Value = data.IdFarmaco;
                cmd.Parameters.Add(new SqlParameter("@fecha", SqlDbType.Date)).Value = data.Fecha;
                cmd.Parameters.Add(new SqlParameter("@tipo", SqlDbType.VarChar, 30)).Value = data.Tipo;
                cmd.Parameters.Add(new SqlParameter("@dosis", SqlDbType.Float, 2)).Value = data.Dosis;
                cmd.Parameters.Add(new SqlParameter("@observacion", SqlDbType.VarChar, 50)).Value = data.Observacion;
                cmd.Parameters.Add(new SqlParameter("@areaAplicacion", SqlDbType.VarChar, 30)).Value = data.AreaAplicacion;
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

        public async Task<List<DAOTratamiento>> ObtenerTratamientoPorFinca(int idFinca)
        {
            SqlParameter parametro = new SqlParameter("@idFinca", SqlDbType.Int);
            parametro.Value = idFinca;
            return await ObtenerPor("uspObtenerTratamientoPorFinca", parametro);
        }

        public async Task<List<DAOTratamiento>> ObtenerTratamientoPorGanado(string idGanado)
        {
            SqlParameter parametro = new SqlParameter("@idGanado", SqlDbType.VarChar, 30);
            parametro.Value = idGanado;
            return await ObtenerPor("uspObtenerTratamientoPorGanado", parametro);
        }

        public async Task<List<DAOTratamiento>> ObtenerTratamientoPorGrupo(int idGrupo)
        {
            SqlParameter parametro = new SqlParameter("@idUsuario", SqlDbType.Int);
            parametro.Value = idGrupo;
            return await ObtenerPor("uspObtenerTratamientoPorGrupo", parametro);
        }

        public async Task<List<DAOTratamiento>> ObtenerTratamientosPorUsuario(int idUsuario)
        {
            SqlParameter parametro = new SqlParameter("@idUsuario", SqlDbType.Int);
            parametro.Value = idUsuario;
            return await ObtenerPor("uspObtenerTratamientoPorUsuario", parametro);
        }

        private async Task<List<DAOTratamiento>> ObtenerPor(string procedimientoAlmacenado, SqlParameter parametro)
        {
            List<DAOTratamiento> listaTratamiento = new List<DAOTratamiento>();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand(procedimientoAlmacenado, conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(parametro);
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            listaTratamiento.Add(new DAOTratamiento()
                            {
                                Id = Convert.ToInt32(dr["IdTratamiento"]),
                                IdGanado = dr["IdGanado"].ToString(),
                                Fecha = Convert.ToDateTime(dr["Fecha"]),
                                Tipo = dr["Tipo"].ToString(),
                                Dosis = (float)dr["Dosis"],
                                Observacion = dr["Observacion"].ToString(),
                                AreaAplicacion = dr["AreaAplicacion"].ToString(),
                                NombreFarmaco = dr["NombreFarmaco"].ToString(),
                            });
                        }
                    }
                    return listaTratamiento;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
