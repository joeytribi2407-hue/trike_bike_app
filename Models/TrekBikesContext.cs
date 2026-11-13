using Microsoft.EntityFrameworkCore;

namespace WebApi.Models;

public class TrekBikesContext : DbContext
{
    public TrekBikesContext(DbContextOptions options) : base(options){}

    public DbSet<Category> Categories { get; set; }
    public DbSet<SubCategory> SubCategories { get; set; }
    public DbSet<Member> Members { get; set; }
    public DbSet<Bike> Bikes { get; set; }
    public DbSet<Cart> Carts { get; set; }
    public DbSet<Status> Statuses { get; set; }
    public DbSet<Invoice> Invoices { get; set; }
}