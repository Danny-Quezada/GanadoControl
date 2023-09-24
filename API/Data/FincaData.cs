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
    public class FincaData : IFincaRepository
    {
        public async Task<List<DAOFinca>> GetAllFincaByUsuario(int IdUsuario)
        {
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspGetAllFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdUsuario", SqlDbType.Int)).Value = IdUsuario;
                try
                {
                    await conexion.OpenAsync();
                    SqlDataReader dr = await cmd.ExecuteReaderAsync();
                    List<DAOFinca> fincas = new List<DAOFinca>();
                    while (dr.Read())
                    {

                        DAOFinca gando = new DAOFinca()
                        {
                            IdFinca = Convert.ToInt32(dr["IdFinca"]),
                            Grupos = Convert.ToInt32(dr["Grupos"]),
                            Ubicacion = dr["Ubicacion"].ToString(),
                            Hectareas = Convert.ToInt32(dr["Hectareas"]),
                            FotoURL = dr["FotoURL"].ToString()
                        };

                        fincas.Add(gando);
                    }

                    return fincas;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<Finca> GetFinca(int Id)
        {
            Finca finca = new Finca();
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspGetFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).Value = Id;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            finca = new Finca()
                            {

                                Id = Convert.ToInt32(dr["IdFinca"]),
                                Nombre = dr["Nombre"].ToString(),
                                Ubicacion = dr["Ubicacion"].ToString(),
                                Hectareas = Convert.ToInt32(dr["Hectareas"]),
                                NombreDueño = dr["NombreDueño"].ToString(),
                            };
                        }
                    }
                    return finca;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<int> GetLastId()
        {
            int id = 0;
            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspUltimoIdFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = await cmd.ExecuteReaderAsync())
                    {
                        while (dr.Read())
                        {
                            id = Convert.ToInt32(dr["IdFinca"]);
                        } 

                    }
                    return id;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task Insertar(Finca finca)
        {

            using (SqlConnection conexion = new SqlConnection(Conexion.Cn))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarFinca", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar, 50)).Value = finca.Nombre;
                cmd.Parameters.Add(new SqlParameter("@Ubicacion", SqlDbType.VarChar, 100)).Value = finca.Ubicacion;
                cmd.Parameters.Add(new SqlParameter("@Hectareas", SqlDbType.Int)).Value = finca.Hectareas;
                cmd.Parameters.Add(new SqlParameter("@NombreDueño", SqlDbType.VarChar, 50)).Value = finca.NombreDueño;
               // ultimoID = (int)cmd.ExecuteScalar();
                
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
