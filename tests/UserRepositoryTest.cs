using System;
using NUnit.Framework;
using Users.Model;
using UserService.DataAccess;
using UserServices.DataAccess.SQL;

namespace UnitTests
{
    [TestFixture]
    public class UserRepositoryTest
    {
        private IUserRepository _userRepository;

        private readonly string _connectionString =
            @"Server=localhost;Database=UsersDb;Trusted_Connection=True;MultipleActiveResultSets=true;Connect Timeout=30;";

        private CUser _user;

        [SetUp]
        public void Setup()
        {
            //arrrange
            _userRepository = new UserRepository(_connectionString);
            _user = new CUser
            {
                FullName = "Test User",
                Id = new Guid("EF31A43B-D345-4CE7-8ACC-3D1CD217C723"),
                Passport = new CPassport
                {
                    Nationality = "Test",
                    PassportId = new Guid("FED59597-F893-450D-BD8F-C6F31B2508C4"),
                    PassportNumber = "test 123"
                },
                RegistrationRegion = new CRegion
                {
                    Name = "test",
                    RegionId = new Guid("41E65243-BCE5-4583-B652-3702702B4C46") // существующий из БД
                }
            };

            
        }

        [TearDown]
        public void DisposeData()
        {
            _user = null;
        }

        [Test]
        public void Should_Be_Create_User_With_Region_And_Passport()
        {
            try
            {
                //act
                /* создадим нового пользователя */
                _userRepository.CreateUser(_user).GetAwaiter().GetResult();
                /*получим из БД созданного пользователя*/
                var newUser = _userRepository.GetUserById(_user.Id).Result;

                //accert
                /* сравним результаты */
                Assert.NotNull(newUser);
                Assert.AreEqual(newUser.Id, _user.Id);
                Assert.AreEqual(newUser.Passport.PassportId, _user.Passport.PassportId);
                Assert.AreEqual(newUser.RegistrationRegion.RegionId, _user.RegistrationRegion.RegionId);
            }
            finally
            {
                /* удалим тестового пользователя */
                _userRepository.DeleteUser(_user.Id).GetAwaiter().GetResult();
            }
        }   
    }
}