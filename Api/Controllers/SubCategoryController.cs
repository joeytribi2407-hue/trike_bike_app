using Microsoft.AspNetCore.Mvc;
using WebApi.Models;

namespace WebApi.Api.Controllers;

[ApiController, Route("api/[controller]")]
public class SubCategoryController : BaseController
{
    [HttpGet]
    public IEnumerable<SubCategory> GetSubCategories()
    {
        return Provider.SubCategory.GetSubCategories();
    }

    [HttpGet("{id}")]
    public IEnumerable<SubCategory> GetSubCategories(short id){
        return Provider.SubCategory.GetSubCategories(id);
    }
}