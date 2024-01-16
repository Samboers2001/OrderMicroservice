using Microsoft.AspNetCore.Mvc;
using OrderMicroservice.Data;
using OrderMicroservice.Models;

namespace OrderMircroservice.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrderController : ControllerBase
    {
        private readonly AppDbContext _appDbContext;

        public OrderController(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Order>> GetAllOrders()
        {
            IEnumerable<Order> orders = _appDbContext.Orders.ToList();
            return Ok(orders);
        }
    }
}

