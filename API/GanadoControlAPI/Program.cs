using Data.Repository;
using Models.Interfaces;


var builder = WebApplication.CreateBuilder(args);
// Add services to the container.

builder.Services.AddHttpContextAccessor();
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
builder.Services.AddScoped<IGanadoRepository>(provider => new GanadoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IDetalleGanadoRepository>(provider => new DetalleGanadoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IFincaRepository>(provider => new FincaData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IDetalleFincaFotoRepository>(provider => new DetalleFincaFotoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IGrupoRepository>(provider => new GrupoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IDetalleGrupoFotoRepository>(provider => new DetalleGrupoFotoData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IDetalleFincaRepository>(provider => new DetalleFincaData(builder.Configuration["ConnectionString"]));
builder.Services.AddScoped<IDocumentoRepository>(provider => new DocumentoData(builder.Configuration["ConnectionString"]));

//http://direccion ip:5000
builder.WebHost.UseUrls("http://192.168.1.4:5000");
var app = builder.Build();
// Configure the HTTP request pipeline.

app.UseSwagger();
app.UseSwaggerUI();


app.UseStaticFiles();

app.UseAuthorization();

app.MapControllers();

app.Run();
