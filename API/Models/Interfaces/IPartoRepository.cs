using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IPartoRepository: IData<Parto>
    {
        Task<bool> EliminarParto(int id);
    }
}
