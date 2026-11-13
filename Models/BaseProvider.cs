namespace WebApi.Models;

public abstract class BaseProvider
{
    TrekBikesContext? context;
    IHttpContextAccessor accessor;
    public BaseProvider(IHttpContextAccessor accessor)
    {
        this.accessor = accessor;
    }

    protected TrekBikesContext Context => context ??= accessor.HttpContext!.RequestServices.GetRequiredService<TrekBikesContext>();
}