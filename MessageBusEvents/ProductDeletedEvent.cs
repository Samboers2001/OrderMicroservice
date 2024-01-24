namespace OrderMicroservice.MessageBusEvents
{
    public class ProductDeletedEvent
    {
        public int ExternalProductId { get; set; }
    }
}