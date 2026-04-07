using System.ServiceModel;

namespace BellaStoreService
{
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        decimal GetDiscountedTotal(decimal subtotal, string couponCode);

        [OperationContract]
        string GetCouponDescription(string couponCode);
    }
}