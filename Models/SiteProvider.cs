namespace WebApi.Models;

public class SiteProvider : BaseProvider
{
    public SiteProvider(IHttpContextAccessor accessor) : base(accessor)
    {
    }
    //fields
    CategoryRepository? category;
    //properties
    public CategoryRepository Category => category ??= new CategoryRepository(Context);
    SubCategoryRepository? subCategory;
    //properties
    public SubCategoryRepository SubCategory => subCategory ??= new SubCategoryRepository(Context);
    MemberRepository? member;
    //properties
    public MemberRepository Member => member ??= new MemberRepository(Context);

    BikeRepository? bike;

    public BikeRepository Bike => bike ??= new BikeRepository(Context);

    CartRepository? cart;

    public CartRepository Cart => cart ??= new CartRepository(Context);

    InvoiceRepository? invoice;

    public InvoiceRepository Invoice => invoice ??= new InvoiceRepository(Context);
    StatusRepository? status;

    public StatusRepository Status => status ??= new StatusRepository(Context);
}