using System;
using System.Data;
using System.Threading.Tasks;
using UserService.DataAccess;

namespace UserServices.DataAccess.SQL
{
    public class AnswerRepository : DefaultRepository, IAnswerRepository
    {
        public AnswerRepository(string connectionString) : base(connectionString)
        {
        }

        public async Task CreateAnswerFree(byte[] file, Guid questionId, Guid testExistId)
        {
            if (file == null)
            {
                throw new ArgumentNullException(nameof(file));
            }

            await ExecuteAsync("up_CreateAnswerFree", 
                new { questionId, data = file, test_exist_id = testExistId }, CommandType.StoredProcedure);
        }

       
    }
}