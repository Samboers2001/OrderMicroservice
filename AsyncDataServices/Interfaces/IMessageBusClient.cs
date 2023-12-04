using OrderMicroservice.Dtos;
namespace OrderMicroservice.AsyncDataServices.Interfaces
{
    public interface IMessageBusClient
    {
        void PublishNewMessage(MessagePublishedDto messagePublishedDto);
    }
}