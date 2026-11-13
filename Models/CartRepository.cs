using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace WebApi.Models;

public class CartRepository : BaseRepository
{
    public CartRepository(TrekBikesContext context) : base(context)
    {
        
    }
    public int Delete(int id){
        Cart? cart = context.Carts.Find(id);
        if(cart != null){
            context.Carts.Remove(cart);
            return context.SaveChanges();
        }  
        return -1;
    }
    public IEnumerable<Cart> GetCarts(string memberId)
    {
        return context.Carts.Where(p => p.MemberId == memberId).Include(p => p.Bike).ToList();
    }
    public int Add(Cart obj)
    {
        string sql = " Exec Addcart @MemberId, @BikeId, @Quantity";
        return context.Database.ExecuteSqlRaw(sql, new SqlParameter[]
        {
            new SqlParameter("@MemberId", obj.MemberId),
            new SqlParameter("@BikeId", obj.BikeId),
            new SqlParameter("@Quantity", obj.Quantity)
            
        });
        
    }
}