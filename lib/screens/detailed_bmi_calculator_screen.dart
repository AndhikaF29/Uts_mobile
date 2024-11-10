import 'package:flutter/material.dart';

class DetailedBmiCalculatorScreen extends StatefulWidget {
  const DetailedBmiCalculatorScreen({super.key});

  @override
  State<DetailedBmiCalculatorScreen> createState() => _DetailedBmiCalculatorScreenState();
}

class _DetailedBmiCalculatorScreenState extends State<DetailedBmiCalculatorScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  String _gender = 'Pria';
  Map<String, dynamic> _results = {};

  void _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty || _ageController.text.isEmpty) return;

    double height = double.parse(_heightController.text) / 100; // cm to m
    double weight = double.parse(_weightController.text);
    int age = int.parse(_ageController.text);

    double bmi = weight / (height * height);
    String category;
    Color categoryColor;
    double idealWeight;
    double bodyFat;

    // Kategori BMI
    if (bmi < 18.5) {
      category = 'Berat Badan Kurang';
      categoryColor = Colors.blue;
    } else if (bmi < 25) {
      category = 'Berat Badan Normal';
      categoryColor = Colors.green;
    } else if (bmi < 30) {
      category = 'Berat Badan Berlebih';
      categoryColor = Colors.orange;
    } else {
      category = 'Obesitas';
      categoryColor = Colors.red;
    }

    // Berat badan ideal (Rumus Hamwi)
    if (_gender == 'Pria') {
      idealWeight = 48 + 2.7 * ((height * 100) - 152.4) / 2.54;
      bodyFat = 1.20 * bmi + 0.23 * age - 16.2;
    } else {
      idealWeight = 45.5 + 2.2 * ((height * 100) - 152.4) / 2.54;
      bodyFat = 1.20 * bmi + 0.23 * age - 5.4;
    }

    setState(() {
      _results = {
        'bmi': bmi,
        'category': category,
        'categoryColor': categoryColor,
        'idealWeight': idealWeight,
        'bodyFat': bodyFat,
        'weightDifference': weight - idealWeight,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator IMT Detail'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Pria', label: Text('Pria')),
                ButtonSegment(value: 'Wanita', label: Text('Wanita')),
              ],
              selected: {_gender},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _gender = newSelection.first;
                  _calculateBMI();
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Umur',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tinggi Badan (cm)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat Badan (kg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            SizedBox(height: 24),
            if (_results.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'IMT: ${_results['bmi'].toStringAsFixed(1)}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _results['category'],
                        style: TextStyle(
                          fontSize: 20,
                          color: _results['categoryColor'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Berat Badan Ideal',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${_results['idealWeight'].toStringAsFixed(1)} kg',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      Text(
                        _results['weightDifference'] > 0
                            ? '(${_results['weightDifference'].toStringAsFixed(1)} kg berlebih)'
                            : '(${(-_results['weightDifference']).toStringAsFixed(1)} kg kurang)',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Estimasi Lemak Tubuh',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${_results['bodyFat'].toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }
} 