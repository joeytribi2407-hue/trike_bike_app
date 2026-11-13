using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApi.Api.Controllers;
using WebApi.Models;

[Authorize,ApiController,Route("api/[controller]")]
public class CartController : BaseController
{
    [HttpDelete("{id}")]
    public int Delete(int id)
    {
        return Provider.Cart.Delete(id);
    }

    [HttpGet]
    public IEnumerable<object>? GetCarts()
    {
        string? memberId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (!string.IsNullOrEmpty(memberId))
        {
            return Provider.Cart.GetCarts(memberId).Select(p => new{
                p.Id,
                p.BikeId,
                p.Quantity,
                p.MemberId,
                p.Bike!.Price,
                p.Bike!.ImageUrl,
                p.Bike!.Name,
            });
        }
        return null;
    }
    [HttpPost]
    public int Add(Cart obj)
    {
        if (ModelState.IsValid)
        {
            obj.MemberId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            return Provider.Cart.Add(obj);
        }
        return -2;
    }
}