using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models;

[Table("Invoice")]
public class Invoice
{
    [Column("InvoiceId")]
    public long Id { get; set; }

    public string? MemberId { get; set; } = null!;

    public int StatusId { get; set; }

    [Column("InvoiceDate")]
    public DateTime? Dated { get; set; }
}