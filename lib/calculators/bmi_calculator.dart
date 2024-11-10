class BmiCalculator {
  static Map<String, dynamic> calculateBmi(double weight, double height) {
    double bmi = weight / (height * height);
    String category;

    if (bmi < 18.5) {
      category = "Berat Badan Kurang";
    } else if (bmi >= 18.5 && bmi < 25) {
      category = "Berat Badan Normal";
    } else if (bmi >= 25 && bmi < 30) {
      category = "Kelebihan Berat Badan";
    } else {
      category = "Obesitas";
    }

    return {
      'bmi': bmi,
      'category': category,
    };
  }
} 