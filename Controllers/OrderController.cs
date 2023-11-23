using Microsoft.AspNetCore.Mvc;

namespace OrderMircroservice.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrderController : ControllerBase
    {
        [HttpGet]
        public ActionResult<string> Get()
        {
            return Ok("Hello from OrderController! And by the way this works too!");
        }
    }
}

