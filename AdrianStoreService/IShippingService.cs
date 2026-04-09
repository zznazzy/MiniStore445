using System.ServiceModel;

namespace AdrianStoreService
{
    [ServiceContract]
    public interface IShippingService
    {
        [OperationContract]
        decimal CalculateShipping(decimal subtotal, string region);
    }
}
