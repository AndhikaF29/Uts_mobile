import 'package:flutter/material.dart';

class TargetZoneCalculatorScreen extends StatefulWidget {
  const TargetZoneCalculatorScreen({super.key});

  @override
  State<TargetZoneCalculatorScreen> createState() => _TargetZoneCalculatorScreenState();
}

class _TargetZoneCalculatorScreenState extends State<TargetZoneCalculatorScreen> {
  final _ageController = TextEditingController();
  final _restingHRController = TextEditingController();
  int _maxHR = 0;
  Map<String, List<int>> _zones = {};

  void _calculateZones() {
    if (_ageController.text.isEmpty || _restingHRController.text.isEmpty) return;

    int age = int.parse(_ageController.text);
    int restingHR = int.parse(_restingHRController.text);
    
    setState(() {
      _maxHR = 220 - age;
      int reserveHR = _maxHR - restingHR;

      _zones = {
        'Zone 1 (50-60%)': [
          (reserveHR * 0.5 + restingHR).round(),
          (reserveHR * 0.6 + restingHR).round()
        ],
        'Zone 2 (60-70%)': [
          (reserveHR * 0.6 + restingHR).round(),
          (reserveHR * 0.7 + restingHR).round()
        ],
        'Zone 3 (70-80%)': [
          (reserveHR * 0.7 + restingHR).round(),
          (reserveHR * 0.8 + restingHR).round()
        ],
        'Zone 4 (80-90%)': [
          (reserveHR * 0.8 + restingHR).round(),
          (reserveHR * 0.9 + restingHR).round()
        ],
        'Zone 5 (90-100%)': [
          (reserveHR * 0.9 + restingHR).round(),
          _maxHR
        ],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Target Zona Latihan'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Umur',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateZones(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _restingHRController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Detak Jantung Istirahat (bpm)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculateZones(),
            ),
            SizedBox(height: 24),
            if (_maxHR > 0) ...[
              Text(
                'Detak Jantung Maksimal: $_maxHR bpm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _zones.length,
                  itemBuilder: (context, index) {
                    String zone = _zones.keys.elementAt(index);
                    List<int> range = _zones[zone]!;
                    return Card(
                      child: ListTile(
                        title: Text(zone),
                        subtitle: Text('${range[0]} - ${range[1]} bpm'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _restingHRController.dispose();
    super.dispose();
  }
} 