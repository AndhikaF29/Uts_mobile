import 'package:flutter/material.dart';
import 'dart:math';

class StatisticsCalculatorScreen extends StatefulWidget {
  const StatisticsCalculatorScreen({super.key});

  @override
  State<StatisticsCalculatorScreen> createState() => _StatisticsCalculatorScreenState();
}

class _StatisticsCalculatorScreenState extends State<StatisticsCalculatorScreen> {
  final TextEditingController _numbersController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  
  String _selectedCalculation = 'Mean, Median, Modus';
  Map<String, dynamic> _result = {};

  void _calculate() {
    switch (_selectedCalculation) {
      case 'Mean, Median, Modus':
        _calculateMMM();
        break;
      case 'Standar Deviasi':
        _calculateStandardDeviation();
        break;
      case 'Probabilitas':
        _calculateProbability();
        break;
      case 'Persentase':
        _calculatePercentage();
        break;
    }
    setState(() {});
  }

  void _calculateMMM() {
    List<double> numbers = _numbersController.text
        .split(',')
        .map((e) => double.tryParse(e.trim()) ?? 0)
        .toList();
    
    if (numbers.isEmpty) return;

    // Mean
    double mean = numbers.reduce((a, b) => a + b) / numbers.length;
    
    // Median
    numbers.sort();
    double median = numbers.length % 2 == 0
        ? (numbers[numbers.length ~/ 2 - 1] + numbers[numbers.length ~/ 2]) / 2
        : numbers[numbers.length ~/ 2];
    
    // Mode
    Map<double, int> frequency = {};
    numbers.forEach((number) {
      frequency[number] = (frequency[number] ?? 0) + 1;
    });
    
    int maxFrequency = frequency.values.reduce(max);
    List<double> modes = frequency.entries
        .where((entry) => entry.value == maxFrequency)
        .map((entry) => entry.key)
        .toList();

    _result = {
      'Mean': mean.toStringAsFixed(2),
      'Median': median.toStringAsFixed(2),
      'Modus': modes.join(', '),
    };
  }

  void _calculateStandardDeviation() {
    List<double> numbers = _numbersController.text
        .split(',')
        .map((e) => double.tryParse(e.trim()) ?? 0)
        .toList();
    
    if (numbers.isEmpty) return;

    double mean = numbers.reduce((a, b) => a + b) / numbers.length;
    double sumSquaredDiff = numbers.map((x) => pow(x - mean, 2).toDouble()).reduce((a, b) => a + b);
    double variance = sumSquaredDiff / (numbers.length - 1);
    double standardDeviation = sqrt(variance);

    _result = {
      'Mean': mean.toStringAsFixed(2),
      'Variance': variance.toStringAsFixed(2),
      'Standar Deviasi': standardDeviation.toStringAsFixed(2),
    };
  }

  void _calculateProbability() {
    double favorableOutcomes = double.tryParse(_valueController.text) ?? 0;
    double totalOutcomes = double.tryParse(_numbersController.text) ?? 0;
    
    if (totalOutcomes > 0) {
      double probability = favorableOutcomes / totalOutcomes;
      _result = {
        'Probabilitas': '${(probability * 100).toStringAsFixed(2)}%',
        'Desimal': probability.toStringAsFixed(4),
      };
    }
  }

  void _calculatePercentage() {
    double value = double.tryParse(_valueController.text) ?? 0;
    double percentage = double.tryParse(_percentageController.text) ?? 0;
    
    double result = value * (percentage / 100);
    double total = value + result;

    _result = {
      'Hasil': result.toStringAsFixed(2),
      'Persentase dari nilai': '${percentage}% dari $value = ${result.toStringAsFixed(2)}',
      'Total': total.toStringAsFixed(2),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          'Kalkulator Statistik',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCalculation,
                    items: [
                      'Mean, Median, Modus',
                      'Standar Deviasi',
                      'Probabilitas',
                      'Persentase'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCalculation = value!;
                        _result.clear();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              if (_selectedCalculation == 'Mean, Median, Modus' ||
                  _selectedCalculation == 'Standar Deviasi')
                _buildInputField(
                  controller: _numbersController,
                  label: 'Masukkan angka (pisahkan dengan koma)',
                ),

              if (_selectedCalculation == 'Probabilitas') ...[
                _buildInputField(
                  controller: _valueController,
                  label: 'Kejadian yang diinginkan',
                ),
                _buildInputField(
                  controller: _numbersController,
                  label: 'Total kejadian',
                ),
              ],

              if (_selectedCalculation == 'Persentase') ...[
                _buildInputField(
                  controller: _valueController,
                  label: 'Nilai',
                ),
                _buildInputField(
                  controller: _percentageController,
                  label: 'Persentase',
                  suffix: '%',
                ),
              ],

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                    ),
                  ),
                ),
              ),

              if (_result.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Hasil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                ..._result.entries.map((entry) => _buildResultCard(
                  entry.key,
                  entry.value,
                )),
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
    String? suffix,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          suffixText: suffix,
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
} 