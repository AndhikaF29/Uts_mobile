import 'package:flutter/material.dart';
import 'dart:math';

class OneRepMaxCalculatorScreen extends StatefulWidget {
  const OneRepMaxCalculatorScreen({super.key});

  @override
  State<OneRepMaxCalculatorScreen> createState() => _OneRepMaxCalculatorScreenState();
}

class _OneRepMaxCalculatorScreenState extends State<OneRepMaxCalculatorScreen> {
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();
  Map<String, double> _results = {};

  void _calculate1RM() {
    if (_weightController.text.isEmpty || _repsController.text.isEmpty) return;

    double weight = double.parse(_weightController.text);
    int reps = int.parse(_repsController.text);

    setState(() {
      // Berbagai formula 1RM
      _results = {
        'Brzycki': weight * (36 / (37 - reps)),
        'Epley': weight * (1 + 0.0333 * reps),
        'Lander': (100 * weight) / (101.3 - 2.67123 * reps),
        'Lombardi': weight * pow(reps, 0.10),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator One Rep Max'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat Beban (kg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculate1RM(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Repetisi',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculate1RM(),
            ),
            SizedBox(height: 24),
            if (_results.isNotEmpty) ...[
              Text(
                'Estimasi 1RM:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ..._results.entries.map((entry) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${entry.value.toStringAsFixed(1)} kg',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }
} 