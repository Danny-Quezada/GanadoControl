using Models.Entities;
using Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data
{
    public class FarmacoData : IFarmacoRepository
    {
        private readonly string cadenaConexion;

        public FarmacoData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }

        public async Task ActualizarFarmaco(Farmaco farmaco)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspActualizarFarmaco", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idFarmaco", SqlDbType.Int)).Value = farmaco.Id;
                cmd.Parameters.Add(new SqlParameter("@nombre", SqlDbType.VarChar, 30)).Value = farmaco.Nombre;
                cmd.Parameters.Add(new SqlParameter("@proveedor", SqlDbType.VarChar, 30)).Value = farmaco.Proveedor;
                cmd.Parameters.Add(new SqlParameter("@tipo", SqlDbType.VarChar, 30)).Value = farmaco.Tipo;
                cmd.Parameters.Add(new SqlParameter("@unidadMedida", SqlDbType.VarChar, 10)).Value = farmaco.UnidadMedida;
                cmd.Parameters.Add(new SqlParameter("@fechaCaducidad", SqlDbType.Date)).Value = farmaco.FechaCaducidad;
                cmd.Parameters.Add(new SqlParameter("@fechaEntrega", SqlDbType.Date)).Value = farmaco.FechaEntrega;
                cmd.Parameters.Add(new SqlParameter("@precio", SqlDbType.Float, 2)).Value = farmaco.Precio;
                cmd.Parameters.Add(new SqlParameter("@cantidad", SqlDbType.Int)).Value = farmaco.Cantidad;
                cmd.Parameters.Add(new SqlParameter("@fotoUrl", SqlDbType.VarChar, 255)).Value = farmaco.FotoURL;
                cmd.Parameters.Add(new SqlParameter("@idFinca", SqlDbType.Int)).Value = farmaco.IdFinca;
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

        public async Task EliminarFarmaco(int id)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspEliminarFarmaco", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@idFarmaco", SqlDbType.Int)).Value = id;
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

        public async Task<int> Insertar(Farmaco data)
        {
            int ultimoId = 0;
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspInsertarFarmaco", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@nombre", SqlDbType.VarChar, 30)).Value = data.Nombre;
                cmd.Parameters.Add(new SqlParameter("@proveedor", SqlDbType.VarChar, 30)).Value = data.Proveedor;
                cmd.Parameters.Add(new SqlParameter("@tipo", SqlDbType.VarChar, 30)).Value = data.Tipo;
                cmd.Parameters.Add(new SqlParameter("@unidadMedida", SqlDbType.VarChar, 10)).Value = data.UnidadMedida;
                cmd.Parameters.Add(new SqlParameter("@fechaCaducidad", SqlDbType.Date)).Value = data.FechaCaducidad;
                cmd.Parameters.Add(new SqlParameter("@fechaEntrega", SqlDbType.Date)).Value = data.FechaEntrega;
                cmd.Parameters.Add(new SqlParameter("@precio", SqlDbType.Float, 2)).Value = data.Precio;
                cmd.Parameters.Add(new SqlParameter("@cantidad", SqlDbType.Int)).Value = data.Cantidad;
                cmd.Parameters.Add(new SqlParameter("@fotoUrl", SqlDbType.VarChar, 255)).Value = data.FotoURL;
                cmd.Parameters.Add(new SqlParameter("@idFinca", SqlDbType.Int)).Value = data.IdFinca;
                try
                {
                    await conexion.OpenAsync();
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            ultimoId = Convert.ToInt32(dr["UltimoID"]);
                        }
                    }
                    return ultimoId;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<List<Farmaco>> ObtenerFarmacosPorFinca(int idFinca)
        {
            List<Farmaco> listaFarmaco = new List<Farmaco>();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspObtenerFarmacosPorFinca", conexion);
                cmd.Parameters.Add(new SqlParameter("@idFinca", SqlDbType.Int)).Value = idFinca;
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            listaFarmaco.Add(new Farmaco()
                            {
                                Id = Convert.ToInt32(dr["IdFarmaco"]),
                                Nombre = dr["Nombre"].ToString(),
                                Proveedor = dr["NombreProveedor"].ToString(),
                                Tipo = dr["Tipo"].ToString(),
                                UnidadMedida = dr["UnidadMedida"].ToString(),
                                FechaCaducidad = Convert.ToDateTime(dr["FechaCaducidad"]),
                                FechaEntrega = Convert.ToDateTime(dr["FechaEntrega"]),
                                Precio = (float)dr["Precio"],
                                Cantidad = Convert.ToInt32(dr["Cantidad"]),
                                IdFinca = Convert.ToInt32(dr["IdFinca"]),
                                FotoURL = dr["FotoURL"].ToString()
                            }); 
                        }
                    }
                    return listaFarmaco;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
