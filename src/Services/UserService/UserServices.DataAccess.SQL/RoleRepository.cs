using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Users.Model;
using UserService.DataAccess;
using System.Data;
using UserServices.DataAccess.SQL.SQLQuery;
using Dapper;

namespace UserServices.DataAccess.SQL
{
    public class RoleRepository : DefaultRepository,  IRoleRepository
    {
        private readonly string _connectionString;

        public RoleRepository(string _connectionString) : base(_connectionString)
        {          
        }

        public async Task CreateRole(CRoles role)
        {
            if (role == null)
            {
                throw new ArgumentNullException(nameof(role));
            }

            await ExecuteAsync("up_CreateUserRole", commandType: CommandType.StoredProcedure, parameters: new
            {
                id = role.Id,
                name = role.Name
            });
        }

        public async Task<CRoles> GetRoleByName(string roleName)
        {
            if (string.IsNullOrEmpty(roleName))
            {

                throw new ArgumentNullException(nameof(roleName));

            }

            return await QueryFirstOrDefaultAsync<CRoles>(CSqlQuery.SelectRoleByName, new
            {
               name = roleName
            }); 
        }

        

        public async Task DeleteRole(Guid roleId)
        {
            if (roleId == Guid.Empty)
            {
                throw new ArgumentOutOfRangeException(nameof(roleId));
            }

            await ExecuteAsync("up_DeleteRole", new { roleId }, CommandType.StoredProcedure);
        }
    }
}
