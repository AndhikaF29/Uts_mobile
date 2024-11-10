import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/currency_format.dart';

class RetirementCalculatorScreen extends StatefulWidget {
  const RetirementCalculatorScreen({super.key});

  @override
  State<RetirementCalculatorScreen> createState() => _RetirementCalculatorScreenState();
}

class _RetirementCalculatorScreenState extends State<RetirementCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  double _currentAge = 25;
  double _retirementAge = 55;
  double _monthlyExpense = 0;
  double _currentSavings = 0;
  double _expectedReturn = 6; // Return investasi tahunan (%)
  double _inflationRate = 4; // Inflasi tahunan (%)
  double _requiredAmount = 0;
  double _monthlySavingsNeeded = 0;

  void _calculateRetirement() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        int yearsToRetirement = _retirementAge.toInt() - _currentAge.toInt();
        int lifeExpectancy = 80; // Asumsi umur hingga 80 tahun
        int retirementDuration = lifeExpectancy - _retirementAge.toInt();

        // Hitung kebutuhan dana pensiun dengan inflasi
        double futureMonthlyExpense = _monthlyExpense * 
            pow((1 + _inflationRate / 100), yearsToRetirement);
        _requiredAmount = futureMonthlyExpense * 12 * retirementDuration;

        // Hitung tabungan bulanan yang dibutuhkan
        double realReturn = (_expectedReturn - _inflationRate) / 100;
        double monthlyRate = realReturn / 12;
        int totalMonths = yearsToRetirement * 12;

        _monthlySavingsNeeded = (_requiredAmount - _currentSavings * 
            pow(1 + realReturn, yearsToRetirement)) * 
            (monthlyRate) / 
            (pow(1 + monthlyRate, totalMonths) - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Dana Pensiun'),
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
                  labelText: 'Usia Saat Ini',
                  suffixText: 'tahun',
                ),
                keyboardType: TextInputType.number,
                initialValue: _currentAge.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
                onChanged: (value) {
                  _currentAge = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Usia Pensiun',
                  suffixText: 'tahun',
                ),
                keyboardType: TextInputType.number,
                initialValue: _retirementAge.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
                onChanged: (value) {
                  _retirementAge = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pengeluaran Bulanan Saat Ini',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  return null;
                },
                onChanged: (value) {
                  _monthlyExpense = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dana Pensiun Saat Ini',
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateRetirement,
                child: const Text('Hitung Dana Pensiun'),
              ),
              const SizedBox(height: 24),
              Text(
                'Total Dana Pensiun yang Dibutuhkan:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormat.formatRupiah(_requiredAmount),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Tabungan Bulanan yang Diperlukan:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormat.formatRupiah(_monthlySavingsNeeded),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 