using OrderMicroservice.Models;

namespace OrderMicroservice.Data.Interfaces
{
    public interface IOrderRepo
    {
        IEnumerable<Order> GetAllOrders();
        void CreateOrder(Order order);
        Order GetOrderByCustomerId(string userId);
        Task<bool> SaveChangesAsync();
    }
}