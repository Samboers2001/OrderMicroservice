using OrderMicroservice.Dtos;
namespace OrderMicroservice.AsyncDataServices
{
    public interface IMessageBusClient
    {
        void PublishNewMessage(MessagePublishedDto messagePublishedDto);
    }
}