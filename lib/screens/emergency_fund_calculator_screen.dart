import 'package:flutter/material.dart';
import '../utils/currency_format.dart';

class EmergencyFundCalculatorScreen extends StatefulWidget {
  const EmergencyFundCalculatorScreen({super.key});

  @override
  State<EmergencyFundCalculatorScreen> createState() => _EmergencyFundCalculatorScreenState();
}

class _EmergencyFundCalculatorScreenState extends State<EmergencyFundCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  double _monthlyIncome = 0;
  double _monthlyExpenses = 0;
  int _monthsCovered = 6; // Default 6 bulan
  double _emergencyFund = 0;
  double _currentSavings = 0;
  double _additionalSavingsNeeded = 0;

  void _calculateEmergencyFund() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _emergencyFund = _monthlyExpenses * _monthsCovered;
        _additionalSavingsNeeded = _emergencyFund - _currentSavings;
        if (_additionalSavingsNeeded < 0) _additionalSavingsNeeded = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Dana Darurat'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Penghasilan Bulanan',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
                onChanged: (value) {
                  _monthlyIncome = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pengeluaran Bulanan',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
                onChanged: (value) {
                  _monthlyExpenses = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dana Darurat Saat Ini',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
                onChanged: (value) {
                  _currentSavings = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Berapa bulan dana darurat yang diinginkan?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Slider(
                value: _monthsCovered.toDouble(),
                min: 3,
                max: 12,
                divisions: 9,
                label: '${_monthsCovered.round()} bulan',
                onChanged: (value) {
                  setState(() {
                    _monthsCovered = value.round();
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateEmergencyFund,
                child: const Text('Hitung Dana Darurat'),
              ),
              const SizedBox(height: 24),
              Text(
                'Total Dana Darurat yang Dibutuhkan:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormat.formatRupiah(_emergencyFund),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Tambahan Dana yang Diperlukan:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormat.formatRupiah(_additionalSavingsNeeded),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 