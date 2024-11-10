import 'package:flutter/material.dart';
import '../utils/currency_format.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  const ZakatCalculatorScreen({super.key});

  @override
  State<ZakatCalculatorScreen> createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  double _savings = 0;
  double _goldPrice = 0;
  double _zakatAmount = 0;

  void _calculateZakat() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        double nisab = 85 * _goldPrice; // 85 gram emas
        if (_savings >= nisab) {
          _zakatAmount = _savings * 0.025; // 2.5% dari harta
        } else {
          _zakatAmount = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Zakat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Harta (Rp)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi total harta';
                  }
                  return null;
                },
                onChanged: (value) {
                  _savings = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Harga Emas per Gram (Rp)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi harga emas';
                  }
                  return null;
                },
                onChanged: (value) {
                  _goldPrice = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateZakat,
                child: const Text('Hitung Zakat'),
              ),
              const SizedBox(height: 24),
              Text(
                'Zakat yang harus dibayar:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormat.formatRupiah(_zakatAmount),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 