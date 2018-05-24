using System;
using NUnit.Framework;
using Users.Model;
using UserService.DataAccess;
using UserServices.DataAccess.SQL;

namespace UnitTests
{
    [TestFixture]

    public class RoleRepositoryTest
    {
        private IRoleRepository _roleRepository;
        private IUserRepository _userRepository;

        private readonly string _connectionString =
            @"Server=localhost;Database=UsersDb;Trusted_Connection=True;MultipleActiveResultSets=true;Connect Timeout=30;";

        private CRoles _role;
        private CUser _user;

        [SetUp]
        public void Setup()
        {
            //arrrange
            _roleRepository = new RoleRepository(_connectionString);
            _role = new CRoles
            {
                Name = "Exemineer",
                Id = new Guid("BD2DBE73-C031-78B7-23FF-0AEF21483453"),
                
            };

            _userRepository = new UserRepository(_connectionString);
            _user = new CUser
            {
               
                Id = new Guid("5A727926-FCE3-A31D-3CE7-10C1CA64F001"),

            };


        }

        [TearDown]
        public void DisposeData()
        {
            _role = null;
        }

        [Test]
        public void Should_Be_Added_Role_To_User()
        {
            try
            {
                

                //создаем роль
                _roleRepository.CreateRole(_role).GetAwaiter().GetResult();
                var createdRole = _roleRepository.GetRoleByName(_role.Name).GetAwaiter().GetResult();
                _userRepository.AddUserToRole(_user.Id, createdRole.Id).GetAwaiter().GetResult();
                //добавляем роль пользователю


                //accert
                /* сравним результаты */
                Assert.NotNull(createdRole);
                Assert.AreEqual(_role.Id, createdRole.Id);
                Assert.AreEqual(_role.Name, createdRole.Name);

            }
            finally
            {
                /* удалим роль */
                _roleRepository.DeleteRole(_role.Id).GetAwaiter().GetResult();
            }
        }
    }
}
