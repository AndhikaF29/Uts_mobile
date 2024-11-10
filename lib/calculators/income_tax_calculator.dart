class IncomeTaxCalculator {
  // PTKP (Penghasilan Tidak Kena Pajak) 2023
  static const double basePTKP = 54000000;       // Wajib pajak
  static const double marriedPTKP = 4500000;     // Tambahan karena menikah
  static const double dependentPTKP = 4500000;   // Per tanggungan (max 3)

  static double calculatePTKP({
    required bool isMarried,
    required int dependents,
  }) {
    double total = basePTKP;
    if (isMarried) total += marriedPTKP;
    total += (dependents.clamp(0, 3) * dependentPTKP);
    return total;
  }

  static double calculateAnnualTax({
    required double annualIncome,
    required double ptkp,
    bool isBPJS = false,
    double bpjsAmount = 0,
  }) {
    double taxableIncome = annualIncome - ptkp;
    if (taxableIncome <= 0) return 0;

    // Pengurangan BPJS (jika ada)
    if (isBPJS) {
      taxableIncome -= bpjsAmount;
    }

    double tax = 0;
    
    // Layer 1: 0 - 60 juta (5%)
    if (taxableIncome <= 60000000) {
      tax = taxableIncome * 0.05;
    } 
    // Layer 2: 60 - 250 juta (15%)
    else if (taxableIncome <= 250000000) {
      tax = (60000000 * 0.05) +
            ((taxableIncome - 60000000) * 0.15);
    }
    // Layer 3: 250 - 500 juta (25%)
    else if (taxableIncome <= 500000000) {
      tax = (60000000 * 0.05) +
            (190000000 * 0.15) +
            ((taxableIncome - 250000000) * 0.25);
    }
    // Layer 4: 500 - 5M (30%)
    else if (taxableIncome <= 5000000000) {
      tax = (60000000 * 0.05) +
            (190000000 * 0.15) +
            (250000000 * 0.25) +
            ((taxableIncome - 500000000) * 0.30);
    }
    // Layer 5: > 5M (35%)
    else {
      tax = (60000000 * 0.05) +
            (190000000 * 0.15) +
            (250000000 * 0.25) +
            (4500000000 * 0.30) +
            ((taxableIncome - 5000000000) * 0.35);
    }

    return tax;
  }

  static double calculateMonthlyTax(double annualTax) {
    return annualTax / 12;
  }
} 