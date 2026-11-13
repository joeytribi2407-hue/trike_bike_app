using WebApi.Services;

namespace WebApi.Models;
public class MemberRepository : BaseRepository
{
    public MemberRepository(TrekBikesContext context) : base(context){}
    public IEnumerable<Member> GetMembers()
    {
        return context.Members.ToList();
    }
    public int Add(Member obj)
    {
        if (context.Members.Where(p => p.Email == obj.Email).Any()) return -1;
        context.Members.Add(obj);
        return context.SaveChanges();
    }

    public Member? GetMember(string id)
    {
        return context.Members.Find(id);
    }

    public Member? GetMemberByEmail(string email)
    {
        //return context.Members.Where(p => p.Email == email).First();
        return context.Members.FirstOrDefault(p=>p.Email == email);
    }
    public LoginResponse Login(LoginModel obj, IConfiguration configuration)
    {
        Member? member = GetMemberByEmail(obj.Email);
        if (member is null) return new LoginResponse
        {
            Success = false,
            Message = "Email invalid"
        };
        if (BCrypt.Net.BCrypt.Verify(obj.Password, member.Password))
        {
            return new LoginResponse
            {
                Success = true,
                Message = "Login Success",
                Token = Helper.GenerateToken(member, configuration)
            };
        }
        return new LoginResponse
        {
            Success = true,
            Message = "Login invali"
        };
    }
}