using Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Interfaces
{
    public interface IInseminacionRepository: IData<Inseminacion>
    {
        Task<bool> EliminarInseminacion(int id);
    }
}
