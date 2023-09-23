using Data.Repository;
using Data;
using Models.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<IUsuarioRepository>(provider => new UsuarioData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<ITratamientoRepository>(provider => new TratamientoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IRecordatorioRepository>(provider => new RecordatorioData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IProblemaFisicoRepository>(provider => new ProblemaFisicoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IPartoRepository>(provider => new PartoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IInseminacionRepository>(provider => new InseminacionData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IFarmacoRepository>(provider => new FarmacoData(builder.Configuration["ConnectionString"]));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
