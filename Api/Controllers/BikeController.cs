using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing.Template;
using WebApi.Models;

namespace WebApi.Api.Controllers;

[ApiController, Route("api/[controller]")]
public class BikeController : BaseController
{
    [HttpGet("details/{id}")]
    public Bike? GetBike(int id)
    {
        return Provider.Bike.GetBike(id);
    }

    [HttpGet]
    public IEnumerable<Bike> GetBikes()
    {
        return Provider.Bike.GetBikes();
    }
    
    [HttpGet ("relation")]
    public IEnumerable<Bike> GetBikesRelation(int id, short subCategoriesId)
    {
        return Provider.Bike.GetBikesRelation(id, subCategoriesId);
    }

    [HttpGet("category/{id}")]
    public IEnumerable<Bike> GetBikesByCategory(short id)
    {
        return Provider.Bike.GetBikesByCategory(id);
    }

    [HttpPost("subcategories")]
    public IEnumerable<Bike> GetBikesBySubCategories(short[] ids)
    {
        return Provider.Bike.GetBikesBySubCategories(ids);
    }
}