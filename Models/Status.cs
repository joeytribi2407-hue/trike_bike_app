using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models;

[Table("Status")]
public class Status
{
    [Column("StatusId")]
    public int Id { get; set; }

    [Column("StatusName")]
    public string Name { get; set; } = null!;
}