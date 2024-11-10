import 'package:flutter/material.dart';
import '../calculators/temperature_converter.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double _result = 0;

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _convertTemperature() {
    if (_tempController.text.isEmpty) return;

    double temp = double.parse(_tempController.text);
    double result;

    if (_fromUnit == _toUnit) {
      result = temp;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      result = TemperatureConverter.celsiusToFahrenheit(temp);
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      result = TemperatureConverter.fahrenheitToCelsius(temp);
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
      result = TemperatureConverter.celsiusToKelvin(temp);
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
      result = TemperatureConverter.kelvinToCelsius(temp);
    } else {
      double celsius;
      if (_fromUnit == 'Fahrenheit') {
        celsius = TemperatureConverter.fahrenheitToCelsius(temp);
      } else {
        celsius = TemperatureConverter.kelvinToCelsius(temp);
      }

      if (_toUnit == 'Fahrenheit') {
        result = TemperatureConverter.celsiusToFahrenheit(celsius);
      } else {
        result = TemperatureConverter.celsiusToKelvin(celsius);
      }
    }

    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade800,
              Colors.orange.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'Konversi Suhu',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Main Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _tempController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Suhu',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.thermostat),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _fromUnit,
                                    decoration: InputDecoration(
                                      labelText: 'Dari',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    items: _units.map((String unit) {
                                      return DropdownMenuItem(
                                        value: unit,
                                        child: Text(unit),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _fromUnit = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _toUnit,
                                    decoration: InputDecoration(
                                      labelText: 'Ke',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    items: _units.map((String unit) {
                                      return DropdownMenuItem(
                                        value: unit,
                                        child: Text(unit),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _toUnit = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _convertTemperature,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Konversi',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (_result != 0)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.orange.shade200,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Hasil Konversi',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_result.toStringAsFixed(2)}° $_toUnit',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }
}
