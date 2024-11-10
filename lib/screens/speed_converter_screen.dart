import 'package:flutter/material.dart';

class SpeedConverterScreen extends StatefulWidget {
  const SpeedConverterScreen({super.key});

  @override
  State<SpeedConverterScreen> createState() => _SpeedConverterScreenState();
}

class _SpeedConverterScreenState extends State<SpeedConverterScreen> {
  final units = ['m/s', 'km/h', 'mph', 'knot', 'ft/s'];
  String _fromUnit = 'km/h';
  String _toUnit = 'm/s';
  final _inputController = TextEditingController();
  String _result = '';

  // Faktor konversi ke m/s
  final Map<String, double> _toMeterPerSecond = {
    'm/s': 1,
    'km/h': 0.277778,
    'mph': 0.44704,
    'knot': 0.514444,
    'ft/s': 0.3048,
  };

  void _convert() {
    if (_inputController.text.isEmpty) return;
    
    double input = double.parse(_inputController.text);
    double result;
    
    // Konversi ke m/s terlebih dahulu
    double inMeterPerSecond = input * _toMeterPerSecond[_fromUnit]!;
    
    // Konversi dari m/s ke unit target
    result = inMeterPerSecond / _toMeterPerSecond[_toUnit]!;
    
    setState(() {
      _result = result.toStringAsFixed(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Kecepatan'),
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