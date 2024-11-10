import 'package:flutter/material.dart';

class PaceCalculatorScreen extends StatefulWidget {
  const PaceCalculatorScreen({super.key});

  @override
  State<PaceCalculatorScreen> createState() => _PaceCalculatorScreenState();
}

class _PaceCalculatorScreenState extends State<PaceCalculatorScreen> {
  final _distanceController = TextEditingController();
  final _hoursController = TextEditingController();
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();
  String _pace = '';
  String _speed = '';

  void _calculatePace() {
    if (_distanceController.text.isEmpty) return;
    
    double distance = double.parse(_distanceController.text);
    int hours = int.tryParse(_hoursController.text) ?? 0;
    int minutes = int.tryParse(_minutesController.text) ?? 0;
    int seconds = int.tryParse(_secondsController.text) ?? 0;

    double totalTimeInHours = hours + (minutes / 60) + (seconds / 3600);
    double totalTimeInMinutes = hours * 60 + minutes + (seconds / 60);

    if (totalTimeInHours > 0 && distance > 0) {
      // Pace in minutes per kilometer
      double paceMinutes = totalTimeInMinutes / distance;
      int paceMin = paceMinutes.floor();
      int paceSec = ((paceMinutes - paceMin) * 60).round();

      // Speed in km/h
      double speed = distance / totalTimeInHours;

      setState(() {
        _pace = '$paceMin:${paceSec.toString().padLeft(2, '0')} /km';
        _speed = '${speed.toStringAsFixed(2)} km/h';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Pace Lari'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jarak (km)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculatePace(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Jam',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _calculatePace(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _minutesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Menit',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _calculatePace(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _secondsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Detik',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _calculatePace(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            if (_pace.isNotEmpty) ...[
              Text(
                'Pace: $_pace',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Kecepatan: $_speed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }
} 