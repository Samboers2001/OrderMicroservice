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

        public IEnumerable<Order> GetAllOrders()
        {
            return _context.Orders.ToList();
        }

        public Order GetOrderByCustomerId(string userId)
        {
            return _context.Orders.FirstOrDefault(o => o.CustomerId == userId);
        }

        public async Task<bool> SaveChangesAsync()
        {
            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (Exception)
            {
                // Handle any exceptions that occur during saving changes
                return false;
            }
        }
    }
}