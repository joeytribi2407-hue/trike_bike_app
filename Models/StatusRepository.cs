using WebApi.Models;

public class StatusRepository : BaseRepository
{
    public StatusRepository(TrekBikesContext context) : base(context)
    {
    }

    public IEnumerable<Status> GetStatuses()=> context.Statuses.ToList();
    
}