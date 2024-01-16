using Microsoft.AspNetCore.Mvc;
using OrderMicroservice.Data;
using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Models;

namespace OrderMircroservice.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrderController : ControllerBase
    {
        private readonly IOrderRepo _repository;

        public OrderController(IOrderRepo repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public ActionResult<IEnumerable<Order>> GetAllOrders()
        {
            var orders = _repository.GetAllOrders();
            return Ok(orders);
        }
    }
}

