using System;
using System.Threading.Tasks;
using Users.Model;

namespace UserService.DataAccess
{
    public interface IRoleRepository
    {
        Task<CRoles> GetRoleByName(string roleName);
        Task CreateRole(CRoles role);
        Task DeleteRole(Guid roleId);

    }
}
