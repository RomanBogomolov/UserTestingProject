using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using Dapper;
using Users.Model;

namespace UserServices.DataAccess.SQL
{
    public class DefaultRepository
    {
        private readonly string _connectionString;
        public DefaultRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public IDbConnection CreateConnection()
        {
            var connection = new SqlConnection(_connectionString);
            return connection;
        }

        protected async Task<T> QueryFirstOrDefaultAsync<T>(string sql, object parameters = null,
            CommandType? commandType = null)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                return await connection.QueryFirstOrDefaultAsync<T>(sql, parameters, commandType: commandType);
            }
        }

        protected async Task<int> ExecuteAsync(string sql, object parameters = null, CommandType? commandType = null)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                return await connection.ExecuteAsync(sql, parameters, commandType: commandType);
            }
        }

        protected async Task<IEnumerable<T>> QueryAsync<T>(string sql, object parameters = null, CommandType? type = null)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                return (await connection.QueryAsync<T>(sql, parameters, commandType: type)).ToList();
            }
        }

        protected async Task<IEnumerable<TParent>> QueryMultiClassAsync<TParent, TChild>(
            string sql,
            object param = null,
            string splitOn = "Id",
            CommandType? type = null,
            string splitTableName = ""
        )
        {
            using (var connection = CreateConnection())
            {
                return await connection.QueryAsync<TParent, TChild, TParent>(sql, (p, c) =>
                {
                    PropertyInfo propertyInfo = p.GetType().GetProperty(splitTableName) ??
                                                p.GetType().GetProperty(typeof(TChild).Name);
                    if (propertyInfo != null)
                        propertyInfo.SetValue(p, c);
                    return p;

                    return p;
                }, param, splitOn: splitOn, commandType: type);
            }
        }
    }
}