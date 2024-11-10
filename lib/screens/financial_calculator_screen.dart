import 'package:flutter/material.dart';
import 'dart:math';

class FinancialCalculatorScreen extends StatefulWidget {
  const FinancialCalculatorScreen({super.key});

  @override
  State<FinancialCalculatorScreen> createState() => _FinancialCalculatorScreenState();
}

class _FinancialCalculatorScreenState extends State<FinancialCalculatorScreen> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  
  String _selectedCalculator = 'KPR';
  Map<String, dynamic> _result = {};

  void _calculate() {
    switch (_selectedCalculator) {
      case 'KPR':
        _calculateKPR();
        break;
      case 'Bunga Majemuk':
        _calculateCompoundInterest();
        break;
      case 'Cicilan':
        _calculateMonthlyInstallment();
        break;
      case 'Pajak':
        _calculateIncomeTax();
        break;
    }
    setState(() {});
  }

  void _calculateKPR() {
    double principal = double.tryParse(_loanAmountController.text) ?? 0;
    double rate = (double.tryParse(_interestRateController.text) ?? 0) / 100 / 12;
    int tenure = ((double.tryParse(_tenureController.text) ?? 0) * 12).toInt();

    if (principal > 0 && rate > 0 && tenure > 0) {
      double monthlyPayment = principal * rate * pow(1 + rate, tenure) / (pow(1 + rate, tenure) - 1);
      double totalPayment = monthlyPayment * tenure;
      double totalInterest = totalPayment - principal;

      _result = {
        'Cicilan Bulanan': 'Rp ${monthlyPayment.toStringAsFixed(0)}',
        'Total Pembayaran': 'Rp ${totalPayment.toStringAsFixed(0)}',
        'Total Bunga': 'Rp ${totalInterest.toStringAsFixed(0)}',
      };
    }
  }

  void _calculateCompoundInterest() {
    double principal = double.tryParse(_loanAmountController.text) ?? 0;
    double rate = (double.tryParse(_interestRateController.text) ?? 0) / 100;
    int years = (double.tryParse(_tenureController.text) ?? 0).toInt();

    if (principal > 0 && rate > 0 && years > 0) {
      double amount = principal * pow(1 + rate, years);
      double interest = amount - principal;

      _result = {
        'Jumlah Akhir': 'Rp ${amount.toStringAsFixed(0)}',
        'Total Bunga': 'Rp ${interest.toStringAsFixed(0)}',
      };
    }
  }

  void _calculateMonthlyInstallment() {
    double principal = double.tryParse(_loanAmountController.text) ?? 0;
    double rate = (double.tryParse(_interestRateController.text) ?? 0) / 100 / 12;
    int months = (double.tryParse(_tenureController.text) ?? 0).toInt();

    if (principal > 0 && rate > 0 && months > 0) {
      double monthlyPayment = principal * rate * pow(1 + rate, months) / (pow(1 + rate, months) - 1);
      double totalPayment = monthlyPayment * months;

      _result = {
        'Cicilan per Bulan': 'Rp ${monthlyPayment.toStringAsFixed(0)}',
        'Total Pembayaran': 'Rp ${totalPayment.toStringAsFixed(0)}',
      };
    }
  }

  void _calculateIncomeTax() {
    double annualSalary = (double.tryParse(_salaryController.text) ?? 0) * 12;
    double taxableIncome = annualSalary - 54000000; // PTKP untuk single
    double tax = 0;

    if (taxableIncome > 0) {
      if (taxableIncome <= 50000000) {
        tax = taxableIncome * 0.05;
      } else if (taxableIncome <= 250000000) {
        tax = 2500000 + ((taxableIncome - 50000000) * 0.15);
      } else if (taxableIncome <= 500000000) {
        tax = 32500000 + ((taxableIncome - 250000000) * 0.25);
      } else {
        tax = 95000000 + ((taxableIncome - 500000000) * 0.30);
      }
    }

    _result = {
      'Penghasilan Kena Pajak': 'Rp ${taxableIncome.toStringAsFixed(0)}',
      'Pajak Tahunan': 'Rp ${tax.toStringAsFixed(0)}',
      'Pajak Bulanan': 'Rp ${(tax / 12).toStringAsFixed(0)}',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: const Text(
          'Kalkulator Finansial',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCalculator,
                    items: ['KPR', 'Bunga Majemuk', 'Cicilan', 'Pajak']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCalculator = value!;
                        _result.clear();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_selectedCalculator != 'Pajak') ...[
                _buildInputField(
                  controller: _loanAmountController,
                  label: 'Jumlah Pinjaman/Modal',
                  prefix: 'Rp',
                ),
                _buildInputField(
                  controller: _interestRateController,
                  label: 'Suku Bunga (per tahun)',
                  suffix: '%',
                ),
                _buildInputField(
                  controller: _tenureController,
                  label: _selectedCalculator == 'Cicilan' 
                      ? 'Jangka Waktu (bulan)' 
                      : 'Jangka Waktu (tahun)',
                ),
              ] else ...[
                _buildInputField(
                  controller: _salaryController,
                  label: 'Gaji per Bulan',
                  prefix: 'Rp',
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Hitung',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (_result.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Hasil Perhitungan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 10),
                ..._result.entries.map((entry) => _buildResultCard(
                  entry.key,
                  entry.value,
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    String? prefix,
    String? suffix,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          prefixText: prefix,
          suffixText: suffix,
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
} 