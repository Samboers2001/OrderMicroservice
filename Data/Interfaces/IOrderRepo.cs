using OrderMicroservice.Models;

namespace OrderMicroservice.Data.Interfaces
{
    public interface IOrderRepo
    {
        void CreateOrder(Order order);
    }
}