import 'package:flutter/material.dart';

class VolumeConverterScreen extends StatefulWidget {
  const VolumeConverterScreen({super.key});

  @override
  State<VolumeConverterScreen> createState() => _VolumeConverterScreenState();
}

class _VolumeConverterScreenState extends State<VolumeConverterScreen> {
  final units = ['mL', 'L', 'cm³', 'm³', 'gal', 'oz'];
  String _fromUnit = 'L';
  String _toUnit = 'mL';
  final _inputController = TextEditingController();
  String _result = '';

  final Map<String, double> _toMilliliter = {
    'mL': 1,
    'L': 1000,
    'cm³': 1,
    'm³': 1000000,
    'gal': 3785.41,
    'oz': 29.5735,
  };

  void _convert() {
    if (_inputController.text.isEmpty) return;
    
    double input = double.parse(_inputController.text);
    double result;
    
    // Konversi ke mL terlebih dahulu
    double inMilliliters = input * _toMilliliter[_fromUnit]!;
    
    // Konversi dari mL ke unit target
    result = inMilliliters / _toMilliliter[_toUnit]!;
    
    setState(() {
      _result = result.toStringAsFixed(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Volume'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan nilai',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _convert(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  items: units.map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                      _convert();
                    });
                  },
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toUnit,
                  items: units.map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                      _convert();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Hasil: $_result ${_toUnit}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
} 