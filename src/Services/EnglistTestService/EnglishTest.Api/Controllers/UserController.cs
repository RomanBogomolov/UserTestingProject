using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Users.Model;
using UserService.DataAccess;

namespace EnglishTest.Api.Controllers
{
    [Route("api/[controller]")]
    public class UserController : Controller
    {
        private readonly IUserRepository _repository;

        public UserController(IUserRepository userRepository)
        {
            _repository = userRepository;
        }

        [HttpGet]
        [Route("{id:guid}")]
        public async Task<IActionResult> GetUser(Guid id)
        {
            var user = await _repository.GetUserById(id);
            return Ok(user);
        }

        [HttpPost]
        [Route("register")]
        public async Task<IActionResult> RegisterUser([FromBody] CUser user)
        {
            if (user == null)
            {
                return BadRequest();
            }

            await _repository.CreateUser(user);
            return Ok("Пользователь успешно зарегистрирован");
        }

        [HttpDelete]
        [Route("delete/{id:guid}")]
        public async Task<IActionResult> DeleteUser(Guid id)
        {
            await _repository.DeleteUser(id);
            return Ok($"Пользователь {id} успешно удален");
        }

        [HttpPut]
        [Route("add/{userId:guid}/{roleId:guid}")]
        public async Task<IActionResult> AddUserToRole(Guid userId,Guid roleId)
        {

            await _repository.AddUserToRole(userId, roleId);
            return Ok("Пользователю успешно выданы права");
        }





    }
}