using System;
using System.Collections.Generic;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class CheckoutPricingService
    {
        public static bool TryCalculate(string couponCode, string region, bool requireRegion, out CheckoutPricingSummary summary, out string errorMessage)
        {
            summary = null;
            errorMessage = string.Empty;

            List<StoreCartItemView> cartItems = ShoppingCartService.GetCartItems();
            if (cartItems.Count == 0)
            {
                errorMessage = "Your cart is empty.";
                return false;
            }

            if (requireRegion && string.IsNullOrWhiteSpace(region))
            {
                errorMessage = "Choose a shipping region before checking out.";
                return false;
            }

            decimal subtotal = 0M;
            foreach (StoreCartItemView item in cartItems)
            {
                subtotal += item.LineTotal;
            }

            summary = new CheckoutPricingSummary
            {
                ItemCount = ShoppingCartService.GetItemCount(),
                Subtotal = subtotal,
                CouponCode = (couponCode ?? string.Empty).Trim(),
                Region = (region ?? string.Empty).Trim()
            };

            if (!TryApplyCoupon(summary, out errorMessage))
            {
                return false;
            }

            if (!TryApplyShipping(summary, requireRegion, out errorMessage))
            {
                return false;
            }

            summary.FinalTotal = summary.DiscountedSubtotal + (summary.ShippingCost ?? 0M);
            return true;
        }

        private static bool TryApplyCoupon(CheckoutPricingSummary summary, out string errorMessage)
        {
            errorMessage = string.Empty;

            try
            {
                // Coupon rules come from the Bella service implementation.
                BellaStoreService.Service1 couponService = new BellaStoreService.Service1();
                summary.CouponDescription = couponService.GetCouponDescription(summary.CouponCode);
                summary.DiscountedSubtotal = couponService.GetDiscountedTotal(summary.Subtotal, summary.CouponCode);
                summary.DiscountAmount = summary.Subtotal - summary.DiscountedSubtotal;
                return true;
            }
            catch (Exception ex)
            {
                errorMessage = "Coupon pricing is unavailable right now: " + ex.Message;
                return false;
            }
        }

        private static bool TryApplyShipping(CheckoutPricingSummary summary, bool requireRegion, out string errorMessage)
        {
            errorMessage = string.Empty;

            if (string.IsNullOrWhiteSpace(summary.Region))
            {
                summary.ShippingCost = requireRegion ? (decimal?)null : null;
                return !requireRegion;
            }

            try
            {
                // Shipping rules come from the Adrian shipping service implementation.
                AdrianStoreService.ShippingService shippingService = new AdrianStoreService.ShippingService();
                summary.ShippingCost = shippingService.CalculateShipping(summary.DiscountedSubtotal, summary.Region);
                return true;
            }
            catch (Exception ex)
            {
                errorMessage = "Shipping pricing is unavailable right now: " + ex.Message;
                return false;
            }
        }
    }
}
