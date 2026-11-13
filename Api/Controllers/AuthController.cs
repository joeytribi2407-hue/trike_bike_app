using Microsoft.AspNetCore.Mvc;
using BCrypt.Net;
using WebApi.Models;
using WebApi.Api.Controllers;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
[ApiController,Route("api/[controller]")]
public class AuthController : BaseController
{
    [HttpGet,Authorize]
    public Member? GetMember()
    {
        string? id = User.FindFirstValue(ClaimTypes.NameIdentifier) ;
        if (!string.IsNullOrEmpty(id))
        {
            return Provider.Member.GetMember(id);
        }
        return null;
    }

    [HttpPost("register")]
    public int Add(Member obj)
    {   
        if (ModelState.IsValid)
        {   
            obj.Id = Guid.NewGuid().ToString().Replace("-", string.Empty);
            obj.Password = BCrypt.Net.BCrypt.HashPassword(obj.Password);
            return Provider.Member.Add(obj);
        }
        return -2;
    }
    [HttpPost("login")]
    public LoginResponse? Login(LoginModel obj)
    {
        return Provider.Member.Login(obj, HttpContext.RequestServices.GetRequiredService<IConfiguration>());
    }
}