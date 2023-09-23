using Models.DTO;
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
    public class GrupoData : IGrupoRepository
    {
        public async Task Insertar(Grupo grupo)
        {
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarGrupo", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar, 50)).Value = grupo.Nombre;
                cmd.Parameters.Add(new SqlParameter("@IdFinca", SqlDbType.Int)).Value = grupo.IdFinca;

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
        public async Task<List<DTOGrupo>> GetAll()
        {
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspGetAllGrupos", conexion);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    List<DTOGrupo> grupos = new List<DTOGrupo>();
                    while (dr.Read())
                    {

                        DTOGrupo grupo = new DTOGrupo()
                        {
                            IdGrupo = Convert.ToInt32(dr["idgrupo"]),
                            CantidadGanado = Convert.ToInt32(dr["CantidadDeGanados"]),

                        };

                        grupos.Add(grupo);
                    }

                    return grupos;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<Grupo> GetGrupo(int id)
        {
            Grupo grupo = new Grupo();
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspGetGrupo", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).Value = id;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            grupo = new Grupo()
                            {
                                IdGrupo = Convert.ToInt32(dr["IdGrupo"]),
                                IdFinca = Convert.ToInt32(dr["IdFinca"]),
                                Nombre = dr["Nombre"].ToString(),
                            };
                        }
                    }
                    return grupo;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
