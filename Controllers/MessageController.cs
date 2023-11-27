using Microsoft.AspNetCore.Mvc;
using OrderMicroservice.AsyncDataServices.Interfaces;
using OrderMicroservice.Dtos;
namespace OrderMicroservice.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessageController : ControllerBase
    {
        private readonly IMessageBusClient _messageBusClient;

        public MessageController(IMessageBusClient messageBusClient)
        {
            _messageBusClient = messageBusClient;
        }

        [HttpPost("publish")]
        public IActionResult PublishMessage([FromBody] MessagePublishedDto messageDto)
        {
            // Perform any validation or processing needed for the message data

            // Publish the message using the MessageBusClient
            _messageBusClient.PublishNewMessage(messageDto);

            return Ok("Message published successfully.");
        }
    }
}