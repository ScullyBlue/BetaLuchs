using betaluchs.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);
var connectionString = builder.Configuration.GetConnectionString("BetaluchsContextConnection");

builder.Services.AddDbContext<BetaluchsIdContext>(options =>
     options.UseNpgsql(builder.Configuration["ConnectionStrings:DBConnection"]));

builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
       .AddEntityFrameworkStores<BetaluchsIdContext>();

// Add services to the container.
builder.Services.AddRazorPages().AddRazorPagesOptions(options =>
 {
     options.Conventions.AuthorizePage("/New");
 });

builder.Services.AddEntityFrameworkNpgsql().AddDbContext<BetaluchsContext>(opt => opt.UseNpgsql(builder.Configuration["ConnectionStrings:DBConnection"]));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();

app.Run();
