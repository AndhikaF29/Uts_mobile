import 'package:flutter/material.dart';

class EnergyConverterScreen extends StatefulWidget {
  const EnergyConverterScreen({super.key});

  @override
  State<EnergyConverterScreen> createState() => _EnergyConverterScreenState();
}

class _EnergyConverterScreenState extends State<EnergyConverterScreen> {
  final units = ['Joule', 'Kalori', 'kWh', 'kcal', 'eV'];
  String _fromUnit = 'Joule';
  String _toUnit = 'Kalori';
  final _inputController = TextEditingController();
  String _result = '';

  final Map<String, double> _toJoule = {
    'Joule': 1,
    'Kalori': 4.184,
    'kWh': 3600000,
    'kcal': 4184,
    'eV': 1.602176634e-19,
  };

  void _convert() {
    if (_inputController.text.isEmpty) return;
    
    double input = double.parse(_inputController.text);
    double result;
    
    // Konversi ke Joule terlebih dahulu
    double inJoules = input * _toJoule[_fromUnit]!;
    
    // Konversi dari Joule ke unit target
    result = inJoules / _toJoule[_toUnit]!;
    
    setState(() {
      _result = result.toStringAsFixed(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Energi'),
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