class CurrencyConverter {
  static const Map<String, double> rates = {
    'USD': 15700,  // 1 USD = 15700 IDR
    'EUR': 16800,  // 1 EUR = 16800 IDR
    'SGD': 11500,  // 1 SGD = 11500 IDR
  };

  static double convert(double amount, String fromCurrency, String toCurrency) {
    // Konversi ke IDR dulu
    double amountInIdr;
    if (fromCurrency != 'IDR') {
      amountInIdr = amount * rates[fromCurrency]!;
    } else {
      amountInIdr = amount;
    }

    // Konversi dari IDR ke mata uang tujuan
    if (toCurrency != 'IDR') {
      return amountInIdr / rates[toCurrency]!;
    }
    return amountInIdr;
  }
} 