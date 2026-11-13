namespace WebApi.Api.Controllers;
using Microsoft.AspNetCore.Mvc;
using WebApi.Models;

public abstract class BaseController : ControllerBase
{
    SiteProvider? provider;
    protected SiteProvider Provider => provider ??= HttpContext.RequestServices.GetRequiredService<SiteProvider>();
}