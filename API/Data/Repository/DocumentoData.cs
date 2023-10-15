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
    public class DocumentoData : IDocumentoRepository
    {
        private readonly string cadenaConexion;

        public DocumentoData(string cadenaConexion)
        {
            this.cadenaConexion = cadenaConexion;
        }
        public async Task<List<Documento>> MostrarDocumentos()
        {
            List<Documento> listaDocumentos = new List<Documento>();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspObtenerDocumentos", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    await conexion.OpenAsync();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (await dr.ReadAsync())
                        {
                            listaDocumentos.Add(new Documento()
                            {
                                Id = Convert.ToInt32(dr["Id"]),
                                Titulo = dr["Titulo"].ToString(),
                                Descripcion = dr["Descripcion"].ToString(),
                                FotoURL = dr["FotoURL"].ToString()
                            });
                        }
                    }
                    return listaDocumentos;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

        public async Task<string?> ObtenerDocumento(int id)
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand cmd = new SqlCommand("uspObtenerDocumento", conexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = id;
                try
                {
                    await conexion.OpenAsync();
                    //string? valor = (await cmd.ExecuteScalarAsync()) == null ? null : (await cmd.ExecuteScalarAsync()).ToString();
                    var result = await cmd.ExecuteScalarAsync();
                    if(result == null) return null;
                    else return result.ToString();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
