using System;
using System.Text.Json;
using calculatorApi.Models;
using calculatorApi.Services;
using calculatorApi.Services.RabbitMQProducer.Helper;
using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson.IO;

namespace calculatorApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CalculatorController : Controller {

    private readonly MongoDBService _mongoDBService;

    public CalculatorController(MongoDBService mongoDBService) {
        _mongoDBService = mongoDBService;
    }

    [HttpGet]
    public async Task<List<CalcHistory>> GetAll() {
        return await _mongoDBService.GetAsync();
    }



    [HttpPost]
    public async Task<IActionResult> PostValue([FromBody] CalcHistory calcHistory)
    {
        /*await _mongoDBService.CreateAsync(calcHistory);
        return Created(string.Empty, "Calculation was saved succesfully!");*/
        //BURAYA RABBITMQ PRODUCER KODUMUZ GELECEK

        ProducerMQ pmq = new ProducerMQ();
        string message = JsonSerializer.Serialize(calcHistory);
        pmq.SendMessage(message);
        return Ok();
    }

}






