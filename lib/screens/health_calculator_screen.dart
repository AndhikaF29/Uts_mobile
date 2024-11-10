import 'package:flutter/material.dart';

class HealthCalculatorScreen extends StatefulWidget {
  const HealthCalculatorScreen({super.key});

  @override
  State<HealthCalculatorScreen> createState() => _HealthCalculatorScreenState();
}

class _HealthCalculatorScreenState extends State<HealthCalculatorScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _gender = 'Pria';
  String _activityLevel = 'Ringan';

  double _calories = 0;
  double _water = 0;
  int _sleepHours = 0;

  // Definisikan warna tema
  static const Color primaryColor = Colors.pink;

  void _calculateHealth() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    int age = int.tryParse(_ageController.text) ?? 0;

    // Rumus Harris-Benedict untuk BMR
    double bmr;
    if (_gender == 'Pria') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    // Faktor aktivitas
    double activityFactor = _activityLevel == 'Ringan'
        ? 1.2
        : _activityLevel == 'Sedang'
            ? 1.55
            : 1.9;

    // Kalori harian
    _calories = bmr * activityFactor;

    // Kebutuhan air (ml)
    _water = weight * 30;

    // Kebutuhan tidur berdasarkan usia
    if (age < 18) {
      _sleepHours = 9;
    } else if (age < 65) {
      _sleepHours = 8;
    } else {
      _sleepHours = 7;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Kalkulator Kesehatan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Masukkan Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: _weightController,
                label: 'Berat Badan',
                suffix: 'kg',
                icon: Icons.monitor_weight,
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _heightController,
                label: 'Tinggi Badan',
                suffix: 'cm',
                icon: Icons.height,
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _ageController,
                label: 'Usia',
                suffix: 'tahun',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 15),
              _buildDropdownField(
                value: _gender,
                label: 'Jenis Kelamin',
                items: ['Pria', 'Wanita'],
                icon: Icons.person,
                onChanged: (value) => setState(() => _gender = value!),
              ),
              const SizedBox(height: 15),
              _buildDropdownField(
                value: _activityLevel,
                label: 'Level Aktivitas',
                items: ['Ringan', 'Sedang', 'Berat'],
                icon: Icons.directions_run,
                onChanged: (value) => setState(() => _activityLevel = value!),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateHealth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Hitung',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (_calories > 0) ...[
                const SizedBox(height: 25),
                const Text(
                  'Hasil Perhitungan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a237e),
                  ),
                ),
                const SizedBox(height: 15),
                _buildResultCard(
                  'Kebutuhan Kalori Harian',
                  '${_calories.toStringAsFixed(0)} kkal',
                  Icons.local_fire_department,
                ),
                _buildResultCard(
                  'Kebutuhan Air Minum',
                  '${_water.toStringAsFixed(0)} ml',
                  Icons.water_drop,
                ),
                _buildResultCard(
                  'Kebutuhan Tidur',
                  '$_sleepHours jam',
                  Icons.bedtime,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                suffixText: suffix,
                suffixStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String label,
    required List<String> items,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF1a237e)),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(label),
                isExpanded: true,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
