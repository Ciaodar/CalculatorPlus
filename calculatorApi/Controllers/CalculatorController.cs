﻿using System.Text.Json;
using calculatorApi.Models;
using calculatorApi.Services.RabbitMQProducer.Helper;
using Microsoft.AspNetCore.Mvc;

namespace calculatorApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CalculatorController : Controller {

    //private readonly ProducerMQ _producerMQ;

   /* public CalculatorController(ProducerMQ producerMQ) {
        _producerMQ = producerMQ;
    }*/

    [HttpPost]
    public async Task<IActionResult> PostValue([FromBody] CalcHistory calcHistory)
    {
        ProducerMQ pmq = new ProducerMQ();
        string message = JsonSerializer.Serialize(calcHistory);
        pmq.SendMessage(message);
        return Ok();
    }

}






