using Microsoft.AspNetCore.Mvc;
using WebApi.Api.Controllers;
using WebApi.Models;
namespace WebApi.Api.Controllers;

[ApiController, Route("api/[controller]")]

public class StatusController : BaseController
{
    [HttpGet]

    public IEnumerable<Status> GetStatuses()=> Provider.Status.GetStatuses();
}