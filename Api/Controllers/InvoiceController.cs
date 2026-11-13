using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApi.Models;

namespace WebApi.Api.Controllers;

[Authorize]
[ApiController, Route("api/[controller]")]
public class InvoiceController : BaseController
{
    [HttpPut("status")]
    public int Update(long id, short statusId)
    {
        return Provider.Invoice.Update(id, statusId);
    }
    [HttpGet]
    public IEnumerable<Invoice> GetInvoices()
    {
        return Provider.Invoice.GetInvoices();
    }
    [HttpPost]
    public int Add(Invoice obj)
    {
        string? memberId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (!string.IsNullOrEmpty(memberId))
        {
            obj.MemberId = memberId;
            return Provider.Invoice.Add(obj);
        }
        return -1;
    }
    [HttpGet("details/{id}")]
    public Invoice? GetInvoice (long id)
    {
        return Provider.Invoice.GetInvoice(id);
    }
}