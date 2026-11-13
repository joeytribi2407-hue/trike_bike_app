namespace WebApi.Models;

public class SubCategoryRepository : BaseRepository
{
    public SubCategoryRepository(TrekBikesContext context) : base(context)
    {
    }
    public IEnumerable<SubCategory> GetSubCategories()
    {
        return context.SubCategories.ToList();
    }
    public IEnumerable<SubCategory> GetSubCategories(short Id)
    {
        return context.SubCategories.Where(p => p.CategoryId == Id).ToList();
    }
}