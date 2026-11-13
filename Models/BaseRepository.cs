
namespace WebApi.Models;

public abstract class BaseRepository
{
    protected TrekBikesContext context;
    public BaseRepository(TrekBikesContext context)
    {
        this.context = context;
    }

}