class ZakatCalculator {
  // Nisab setara dengan 85 gram emas
  static double calculateNisab(double goldPricePerGram) {
    return 85 * goldPricePerGram;
  }

  static double calculateZakatMaal({
    required double savings,         // Tabungan
    required double investments,     // Investasi
    required double gold,           // Nilai emas
    required double silver,         // Nilai perak
    required double receivables,    // Piutang
    required double propertyValue,  // Properti untuk bisnis
    required double businessAssets, // Aset bisnis
  }) {
    double totalAssets = savings + 
                        investments + 
                        gold + 
                        silver + 
                        receivables + 
                        propertyValue + 
                        businessAssets;
    
    // Zakat = 2.5% dari total aset
    return totalAssets * 0.025;
  }

  static double calculateZakatFitrah({
    required double ricePrice,      // Harga beras per kg
    required int familyMembers,     // Jumlah anggota keluarga
  }) {
    // 2.5 kg beras per orang
    return ricePrice * 2.5 * familyMembers;
  }
} 