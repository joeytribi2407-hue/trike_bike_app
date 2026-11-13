using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace WebApi.Models;

public class InvoiceRepository : BaseRepository
{
    public InvoiceRepository(TrekBikesContext context) : base(context)
    {
    }
    public int Update(long id, short statusId)
    {
        Invoice? obj = context.Invoices.Find(id);
        if(obj is null)return -1;
        obj.StatusId = statusId;
        context.Update(obj);
        return context.SaveChanges();
    }
    public int Add(Invoice obj)
    {
        return context.Database.ExecuteSqlRaw("AddInvoice @InvoiceId, @MemberId, @StatusId", new SqlParameter[]
        {
            new SqlParameter("@MemberId", obj.MemberId),
            new SqlParameter("@InvoiceId", obj.Id),
            new SqlParameter("@StatusId", obj.StatusId),
        });
    }
    public IEnumerable<Invoice> GetInvoices()
    {
        return context.Invoices.ToList();
    }

    public IEnumerable<Invoice> GetInvoices(string memberId)
    {
        return context.Invoices.Where(p => p.MemberId == memberId).ToList();
    }

    public Invoice? GetInvoice(long id)
    {
        return context.Invoices.Find(id);
    }
}