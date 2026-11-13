using Microsoft.AspNetCore.Mvc;
using WebApi.Models;
using WebApi.Services;

namespace WebApi.Api.Controllers;
[ApiController, Route("api/[controller]")]
public class CategoryController : BaseController
{
    
    public IEnumerable<Category> GetCategories()
    {
        return Provider.Category.GetCategories();
    }
    [HttpPost]
    public async Task<int> Post(Category obj)
    {
        if (ModelState.IsValid)
        {
            obj.Icon = await Helper.DownloadAsync(obj.Icon, "categories",16);
            return Provider.Category.Add(obj);
        }
        return 0;
    }

}