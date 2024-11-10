import 'package:flutter/material.dart';
import '../utils/currency_format.dart';

class IncomeTaxCalculatorScreen extends StatefulWidget {
  const IncomeTaxCalculatorScreen({super.key});

  @override
  State<IncomeTaxCalculatorScreen> createState() => _IncomeTaxCalculatorScreenState();
}

class _IncomeTaxCalculatorScreenState extends State<IncomeTaxCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  double _monthlyIncome = 0;
  bool _isMarried = false;
  int _dependents = 0;
  double _taxAmount = 0;

  void _calculateTax() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        double annualIncome = _monthlyIncome * 12;
        double ptkp = 54000000; // PTKP dasar
        if (_isMarried) ptkp += 4500000;
        ptkp += (_dependents * 4500000); // 4.5jt per tanggungan

        double taxableIncome = annualIncome - ptkp;
        if (taxableIncome <= 0) {
          _taxAmount = 0;
          return;
        }

        // Perhitungan pajak progresif
        if (taxableIncome <= 60000000) {
          _taxAmount = taxableIncome * 0.05;
        } else if (taxableIncome <= 250000000) {
          _taxAmount = (60000000 * 0.05) + ((taxableIncome - 60000000) * 0.15);
        } else if (taxableIncome <= 500000000) {
          _taxAmount = (60000000 * 0.05) + (190000000 * 0.15) + 
                      ((taxableIncome - 250000000) * 0.25);
        } else {
          _taxAmount = (60000000 * 0.05) + (190000000 * 0.15) + 
                      (250000000 * 0.25) + ((taxableIncome - 500000000) * 0.30);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Pajak Penghasilan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Penghasilan per Bulan (Rp)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon isi penghasilan';
                  }
                  return null;
                },
                onChanged: (value) {
                  _monthlyIncome = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Status Pernikahan'),
                subtitle: const Text('Sudah Menikah'),
                value: _isMarried,
                onChanged: (bool value) {
                  setState(() {
                    _isMarried = value;
                  });
                },
              ),
              ListTile(
                title: const Text('Jumlah Tanggungan'),
                trailing: DropdownButton<int>(
                  value: _dependents,
                  items: [0, 1, 2, 3]
                      .map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      })
                      .toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _dependents = newValue;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateTax,
                child: const Text('Hitung Pajak'),
              ),
              const SizedBox(height: 24),
              Text(
                'Pajak Penghasilan per Tahun:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormat.formatRupiah(_taxAmount),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Pajak per Bulan: ${CurrencyFormat.formatRupiah(_taxAmount / 12)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 