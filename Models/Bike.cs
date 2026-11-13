using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models;

[Table("Bike")]
public class Bike
{
    [Column("BikeId")]
    public int Id { get; set; }

    public short SubCategoryId { get; set; }
    public SubCategory? SubCategory { get; set; }

    [Column("BikeName")]
    public string Name { get; set; } = null!;

    //public string Description { get; set; } = null!;

    public string ImageUrl { get; set; } = null!;

    [Column(TypeName = "DECIMAL(10, 2)")]
    public decimal Price { get; set; }

    public string? Frame { get; set; }

    public string? Weight { get; set; }

    public string? Drivetrain { get; set; }

    public string? Wheels { get; set; }

    public string? Fork { get; set; }

    public string? RearShock { get; set; }

    public string? Tires { get; set; }

    public string? Brakes { get; set; }
}