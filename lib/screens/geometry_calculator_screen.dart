import 'package:flutter/material.dart';
import '../calculators/geometry_calculator.dart';

class GeometryCalculatorScreen extends StatefulWidget {
  const GeometryCalculatorScreen({super.key});

  @override
  State<GeometryCalculatorScreen> createState() =>
      _GeometryCalculatorScreenState();
}

class _GeometryCalculatorScreenState extends State<GeometryCalculatorScreen> {
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  String _selectedShape = 'Persegi';
  String _selectedCalculation = 'Luas';
  double _result = 0;

  final Map<String, List<String>> _shapes = {
    'Persegi': ['Luas', 'Volume'],
    'Lingkaran': ['Luas', 'Volume'],
    'Segitiga': ['Luas'],
  };

  IconData _getShapeIcon() {
    switch (_selectedShape) {
      case 'Persegi':
        return Icons.square_outlined;
      case 'Lingkaran':
        return Icons.circle_outlined;
      case 'Segitiga':
        return Icons.change_history_outlined;
      default:
        return Icons.shape_line_outlined;
    }
  }

  void _calculate() {
    if (_input1Controller.text.isEmpty) return;

    double input1 = double.parse(_input1Controller.text);
    double? input2 = _input2Controller.text.isEmpty
        ? null
        : double.parse(_input2Controller.text);

    double result;

    if (_selectedCalculation == 'Luas') {
      switch (_selectedShape) {
        case 'Persegi':
          result = GeometryCalculator.calculateRectangleArea(input1, input1);
          break;
        case 'Lingkaran':
          result = GeometryCalculator.calculateCircleArea(input1);
          break;
        case 'Segitiga':
          if (input2 == null) return;
          result = GeometryCalculator.calculateTriangleArea(input1, input2);
          break;
        default:
          return;
      }
    } else {
      switch (_selectedShape) {
        case 'Persegi':
          result = GeometryCalculator.calculateCubeVolume(input1);
          break;
        case 'Lingkaran':
          result = GeometryCalculator.calculateSphereVolume(input1);
          break;
        default:
          return;
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
              Colors.indigo.shade800,
              Colors.indigo.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
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
                      'Kalkulator Geometri',
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
                            DropdownButtonFormField<String>(
                              value: _selectedShape,
                              decoration: InputDecoration(
                                labelText: 'Pilih Bentuk',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: Icon(_getShapeIcon()),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: _shapes.keys.map((String shape) {
                                return DropdownMenuItem(
                                  value: shape,
                                  child: Text(shape),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedShape = newValue!;
                                  _selectedCalculation =
                                      _shapes[newValue]!.first;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedCalculation,
                              decoration: InputDecoration(
                                labelText: 'Pilih Perhitungan',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: Icon(
                                  _selectedCalculation == 'Luas'
                                      ? Icons.square_foot
                                      : Icons.view_in_ar,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items:
                                  _shapes[_selectedShape]!.map((String calc) {
                                return DropdownMenuItem(
                                  value: calc,
                                  child: Text(calc),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCalculation = newValue!;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _input1Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: _selectedShape == 'Lingkaran'
                                    ? 'Jari-jari'
                                    : 'Sisi/Alas',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.straighten),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            if (_selectedShape == 'Segitiga') ...[
                              const SizedBox(height: 16),
                              TextField(
                                controller: _input2Controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Tinggi',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: const Icon(Icons.height),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _calculate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Hitung',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (_result > 0)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.indigo.shade200,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$_selectedCalculation $_selectedShape',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _result.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade700,
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
    _input1Controller.dispose();
    _input2Controller.dispose();
    super.dispose();
  }
}
