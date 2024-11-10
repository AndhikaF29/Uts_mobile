class BasicCalculator {
  static double add(double a, double b) => a + b;
  static double subtract(double a, double b) => a - b;
  static double multiply(double a, double b) => a * b;
  static double divide(double a, double b) {
    if (b == 0) throw Exception('Tidak bisa membagi dengan nol');
    return a / b;
  }
  
  static double modulo(double a, double b) {
    if (b == 0) throw Exception('Tidak bisa modulo dengan nol');
    return a % b;
  }
} 