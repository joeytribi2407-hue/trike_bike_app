using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using WebApi.Models;

namespace WebApi.Services;

public static class Helper
{

    public static string GenerateToken(Member member, IConfiguration configuration)
    {
        List<Claim> claims = new List<Claim>
        {
            new Claim(ClaimTypes.NameIdentifier, member.Id!),
            new Claim(ClaimTypes.Name, string.IsNullOrEmpty(member.Surname) ? member.GivenName : member.Surname + " " + member.GivenName),
            new Claim(ClaimTypes.Email, member.Email),
            new Claim(ClaimTypes.GivenName, member.GivenName),
            new Claim(ClaimTypes.Role, member.Role.ToString())
        };
        if (!string.IsNullOrEmpty(member.Surname)) claims.Add(new Claim(ClaimTypes.GivenName, member.Surname));

        JwtSecurityTokenHandler handler = new JwtSecurityTokenHandler();
        SymmetricSecurityKey key = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(configuration["Jwt:SecretKey"] ?? throw new KeyNotFoundException("Jwt:SecretKey")));

        JwtSecurityToken token = new JwtSecurityToken(
            issuer: configuration["Jwt:Issuer"],
            audience: configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.Now.AddDays(int.Parse(configuration["Jwt:Expires"] ?? throw new KeyNotFoundException("Jwt:Expires"))),
            signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature)
        );
        return handler.WriteToken(token);
    }
    public static string RandomString(int len)
    {
        string pattern = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        char[] arr = new char[len];
        Random rand = new Random();
        for(int i=0 ; i<len; i++)
        {
            arr[i] = pattern[rand.Next(0, pattern.Length)];
        }
        return string.Join(string.Empty, arr);
    }
    public static async Task<string> DownloadAsync(string url, string folder = "images", int len = 32)
    {
        using(HttpClient client = new HttpClient())
        {
            Stream stream = await client.GetStreamAsync(url);
            string ext = Path.GetExtension(url);
            string fileName = RandomString(len - ext.Length) + ext;
            string path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", folder, fileName);
            using(FileStream fs = new FileStream(path, FileMode.Create))
            {
                stream.CopyTo(fs);
            }
            return fileName;
        }
    }
}