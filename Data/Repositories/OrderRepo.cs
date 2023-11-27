using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Models;

namespace OrderMicroservice.Data.Repositories
{
    public class OrderRepo : IOrderRepo
    {
        private readonly AppDbContext _context;

        public OrderRepo(AppDbContext context)
        {
            _context = context;
        }
        public void CreateOrder(Order order)
        {
            _context.Orders.Add(order);
            _context.SaveChanges();
        }
    }
}