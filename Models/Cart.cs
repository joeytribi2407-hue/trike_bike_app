using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models;
[Table("Cart")]
public class Cart
{
    [Column("CartId")]
    public int Id{ get; set; }
    public string? MemberId { get; set; }
    public int BikeId{ get; set; }
    public Bike? Bike{ get; set; }
    public short Quantity{ get; set; }
    
}