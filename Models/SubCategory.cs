using System.ComponentModel.DataAnnotations.Schema;
namespace WebApi.Models;

[Table("SubCategory")]
public class SubCategory
{
    [Column("SubCategoryId")]
    public short Id { get; set; }
    public short CategoryId { get; set; }
    [Column("SubCategoryName")]
    public string Name { get; set; }=null!;
    public string Title { get; set; }=null!;
    public string Description { get; set; }=null!;
    public string ImageUrl { get; set; }=null!;
}