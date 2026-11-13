using Microsoft.EntityFrameworkCore;

namespace WebApi.Models;

public class BikeRepository : BaseRepository
{
    public BikeRepository(TrekBikesContext context) : base(context){}
        public Bike? GetBike(int id)
    {
        return context.Bikes.Find(id);
    }
    public IEnumerable<Bike> GetBikes()
    {
        return context.Bikes.ToList();
    }

    public IEnumerable<Bike> GetBikesByCategory(short id)
    {
        return context.Bikes.Include(p => p.SubCategory).Where(p => p.SubCategory!.CategoryId == id).ToList();
    }

    public IEnumerable<Bike> GetBikesBySubCategories(short[] ids)
    {
        return context.Bikes.Where(p => ids.Contains(p.SubCategoryId)).ToList();
    }
    public IEnumerable<Bike> GetBikesRelation(int id, short subCategoryId)
    {
        return context.Bikes.Where(p=>p.SubCategoryId==subCategoryId && p.Id != id).ToList();
    }
}