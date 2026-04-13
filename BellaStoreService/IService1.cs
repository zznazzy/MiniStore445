using System.ServiceModel;

namespace BellaStoreService
{
    [ServiceContract]
    public interface IService1
    {
        /// <summary>
        /// Returns the order total after applying a supported coupon percentage.
        /// Input: subtotal amount and optional coupon code string.
        /// Output: discounted total rounded to two decimals.
        /// </summary>
        [OperationContract]
        decimal GetDiscountedTotal(decimal subtotal, string couponCode);

        /// <summary>
        /// Returns a human-readable explanation of how the coupon is interpreted.
        /// Input: optional coupon code string.
        /// Output: discount description text, or a fallback message for invalid/blank codes.
        /// </summary>
        [OperationContract]
        string GetCouponDescription(string couponCode);
    }
}
