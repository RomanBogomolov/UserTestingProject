using System;
using System.Threading.Tasks;
using Users.Model;

namespace UserService.DataAccess
{
    public interface IUserRepository
    {
        Task CreateUser(CUser user);
        Task<CUser> GetUserById(Guid userId);
        Task DeleteUser(Guid userId);
        Task Test();
    }
}