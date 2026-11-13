
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models;

[Table("Category")]
public class Category
{
    [Column("CategoryId")]
    public short Id { get; set; }
    [Column("CategoryName")]
    public string Name { get; set; } = null!;
    public string Title { get; set; } = null!;
    public string Description { get; set; } = null!;
    public string Icon { get; set; } = null!;
}
