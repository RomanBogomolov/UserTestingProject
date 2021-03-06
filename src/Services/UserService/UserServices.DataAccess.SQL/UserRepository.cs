﻿using System;
using System.Data;
using System.Linq;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Dapper;
using Users.Model;
using UserService.DataAccess;
using UserServices.DataAccess.SQL.SQLQuery;

namespace UserServices.DataAccess.SQL
{
    public class UserRepository : DefaultRepository, IUserRepository 
    {
        public UserRepository(string connectionString) : base(connectionString)
        {

        }

        public async Task CreateUser(CUser user)
        {
            if (user == null)
            {
                throw new ArgumentNullException(nameof(user));
            }
            try
            {
                await ExecuteAsync("up_CreateUserPassportUserRole", commandType: CommandType.StoredProcedure, parameters: new
                {
                    id = user.Id,
                    fullname = user.FullName,
                    registrationRegionId = user.RegistrationRegion.RegionId,
                    passportId = user.Passport.PassportId,
                    passportNumber = user.Passport.PassportNumber,
                    nationality = user.Passport.Nationality,
                    other = user.Passport.Other
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                throw;
            }
            
        }

        public async Task<CUser> GetUserById(Guid userId)
        {
            if (userId == Guid.Empty)
            {
                throw new ArgumentOutOfRangeException(nameof(userId));
            }

            using (var connection = CreateConnection())
            {
                connection.Open();

                var data = await connection.QueryAsync<CUser, CRegion, CPassport, CUser>(CSqlQuery.SelectUserById,
                    (user, region, passport) =>
                    {
                        user.Passport = passport;
                        user.RegistrationRegion = region;
                        return user;
                    }, splitOn: "regionId,passportId", param: new { userId });


                return data.ToList().FirstOrDefault();
            }
        }

        public async Task DeleteUser(Guid userId)
        {
            if (userId == Guid.Empty)
            {
                throw new ArgumentOutOfRangeException(nameof(userId));
            }

            await ExecuteAsync("up_DeleteUser", new { userId }, CommandType.StoredProcedure);
        }


        

        public async Task AddUserToRole(Guid userId, Guid roleId)
        {
            if (userId== Guid.Empty)
            {
                throw new ArgumentOutOfRangeException(nameof(userId));
            }

            if (roleId == Guid.Empty)
            {
                throw new ArgumentOutOfRangeException(nameof(roleId));
            }


                await ExecuteAsync("up_AddUserToRole", commandType: CommandType.StoredProcedure, parameters: new
            {
                userId, roleId
            });
        }

       
    }
}