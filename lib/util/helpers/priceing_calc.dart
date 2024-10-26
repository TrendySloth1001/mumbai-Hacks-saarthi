class xpricCalculator {
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTexRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  //shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  //tax
  static String calculateTaxPrice(double productPrice, String loacation) {
    double taxRate = getTexRateForLocation(loacation);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTexRateForLocation(String location) {
    return 5.00;
  }

  static double getShippingCost(String location) {
    return 5.00;
  }
}
