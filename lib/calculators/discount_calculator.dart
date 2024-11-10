class DiscountCalculator {
  static Map<String, double> calculateDiscount(double originalPrice, double discountPercentage) {
    double discountAmount = (discountPercentage / 100) * originalPrice;
    double finalPrice = originalPrice - discountAmount;

    return {
      'discountAmount': discountAmount,
      'finalPrice': finalPrice,
    };
  }
} 