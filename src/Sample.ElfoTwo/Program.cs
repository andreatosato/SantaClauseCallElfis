var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.MapGet("/servicetwotext", () =>
{
    return Results.Ok(new { TextFromService = "and happy new year!" });
})
.WithName("GetServiceTwoText");

app.Run();
