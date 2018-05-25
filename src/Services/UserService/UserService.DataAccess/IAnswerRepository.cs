using System;
using System.Threading.Tasks;

namespace UserService.DataAccess
{
    public interface IAnswerRepository
    {
        Task CreateAnswerFree(byte[] file, Guid questionId, Guid testExistId);
    }
}