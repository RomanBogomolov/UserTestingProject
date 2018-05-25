using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Users.Model;
using UserService.DataAccess;

namespace EnglishTest.Api.Controllers
{
    [Route("api/[controller]")]
    public class FileController : Controller
    {
        private readonly IAnswerRepository _repository;

        public FileController(IAnswerRepository repository)
        {
            _repository = repository;
        }

        [Route("upload/attachment/{questionId:guid}/{testExistId:guid}")]
        [HttpPost]
        public async Task<IActionResult> UploadAttachment(IFormFile file, Guid questionId, Guid testExistId)
        {
            if (file != null)
            {
                byte[] attachment;
                using (var memoryStream = new MemoryStream())
                {
                    await file.CopyToAsync(memoryStream);
                    attachment = memoryStream.ToArray();
                }

                await _repository.CreateAnswerFree(attachment, questionId, testExistId);
                return Ok();
            }

            return BadRequest();
        }
    }
}