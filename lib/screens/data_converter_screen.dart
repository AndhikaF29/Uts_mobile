import 'package:flutter/material.dart';
import 'dart:math';

class DataConverterScreen extends StatefulWidget {
  const DataConverterScreen({super.key});

  @override
  State<DataConverterScreen> createState() => _DataConverterScreenState();
}

class _DataConverterScreenState extends State<DataConverterScreen> {
  final units = ['B', 'KB', 'MB', 'GB', 'TB'];
  String _fromUnit = 'MB';
  String _toUnit = 'GB';
  final _inputController = TextEditingController();
  String _result = '';

  void _convert() {
    if (_inputController.text.isEmpty) return;
    
    double input = double.parse(_inputController.text);
    double result = 0;
    
    // Konversi ke Bytes terlebih dahulu
    double inBytes = input * pow(1024, units.indexOf(_fromUnit));
    
    // Konversi dari Bytes ke unit target
    result = inBytes / pow(1024, units.indexOf(_toUnit));
    
    setState(() {
      _result = result.toStringAsFixed(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Data'),
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