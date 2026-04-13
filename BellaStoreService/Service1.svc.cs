using System;

namespace BellaStoreService
{
    public class Service1 : IService1
    {
        public decimal GetDiscountedTotal(decimal subtotal, string couponCode)
        {
            // Guard against negative subtotals so the service never returns a negative charge.
            if (subtotal < 0)
            {
                subtotal = 0;
            }

            // Discount percentage is selected from known coupon codes; unknown/blank codes return 0%.
            decimal discountPercent = GetDiscountPercent(couponCode);
            decimal total = subtotal * (1 - discountPercent);

            // Round to currency precision for consistent UI/service output.
            return Math.Round(total, 2);
        }

        public string GetCouponDescription(string couponCode)
        {
            // Normalize first so comparisons are case-insensitive and whitespace-safe.
            string normalized = NormalizeCoupon(couponCode);

            switch (normalized)
            {
                case "SAVE10":
                    return "SAVE10 applies a 10% discount.";
                case "STUDENT15":
                    return "STUDENT15 applies a 15% discount.";
                case "VIP20":
                    return "VIP20 applies a 20% discount.";
                default:
                    // Invalid or blank coupon gets the same fallback response.
                    return "No valid coupon applied.";
            }
        }

        private decimal GetDiscountPercent(string couponCode)
        {
            // Normalize once, then map coupon codes to discount percentages.
            string normalized = NormalizeCoupon(couponCode);

            switch (normalized)
            {
                case "SAVE10":
                    return 0.10m;
                case "STUDENT15":
                    return 0.15m;
                case "VIP20":
                    return 0.20m;
                default:
                    // Invalid/blank coupon means no discount.
                    return 0.00m;
            }
        }

        private string NormalizeCoupon(string couponCode)
        {
            // Coupon normalization: null-safe, trim spaces, and uppercase for stable matching.
            return (couponCode ?? string.Empty).Trim().ToUpperInvariant();
        }
    }
}
