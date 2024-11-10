import 'package:flutter/material.dart';
import 'screens/currency_converter_screen.dart';
import 'screens/temperature_converter_screen.dart';
import 'screens/bmi_calculator_screen.dart';
import 'screens/discount_calculator_screen.dart';
import 'screens/geometry_calculator_screen.dart';
import 'screens/basic_calculator_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/health_calculator_screen.dart';
import 'screens/financial_calculator_screen.dart';
import 'screens/data_converter_screen.dart';
import 'screens/speed_converter_screen.dart';
import 'screens/volume_converter_screen.dart';
import 'screens/energy_converter_screen.dart';
import 'screens/target_zone_calculator_screen.dart';
import 'screens/pace_calculator_screen.dart';
import 'screens/one_rep_max_calculator_screen.dart';
import 'screens/detailed_bmi_calculator_screen.dart';
import 'screens/zakat_calculator_screen.dart';
import 'screens/income_tax_calculator_screen.dart';
import 'screens/retirement_calculator_screen.dart';
import 'screens/emergency_fund_calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MyHomePage(),
        '/zakat-calculator': (context) => const ZakatCalculatorScreen(),
        '/income-tax-calculator': (context) => const IncomeTaxCalculatorScreen(),
        '/retirement-calculator': (context) => const RetirementCalculatorScreen(),
        '/emergency-fund-calculator': (context) => const EmergencyFundCalculatorScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Konversi',
      'items': [
        {
          'title': 'Mata\nUang',
          'icon': Icons.currency_exchange,
          'screen': const CurrencyConverterScreen(),
          'color': Colors.green,
        },
        {
          'title': 'Suhu',
          'icon': Icons.thermostat,
          'screen': const TemperatureConverterScreen(),
          'color': Colors.orange,
        },
        {
          'title': 'Data',
          'icon': Icons.data_usage,
          'screen': const DataConverterScreen(),
          'color': Colors.indigo,
        },
        {
          'title': 'Kecepatan',
          'icon': Icons.speed,
          'screen': const SpeedConverterScreen(),
          'color': Colors.purple,
        },
        {
          'title': 'Volume',
          'icon': Icons.water_drop,
          'screen': const VolumeConverterScreen(),
          'color': Colors.cyan,
        },
        {
          'title': 'Energi',
          'icon': Icons.bolt,
          'screen': const EnergyConverterScreen(),
          'color': Colors.amber,
        },
      ],
    },
    {
      'title': 'Matematika',
      'items': [
        {
          'title': 'Dasar',
          'icon': Icons.calculate,
          'screen': const BasicCalculatorScreen(),
          'color': Colors.teal,
        },
        {
          'title': 'Geometri',
          'icon': Icons.architecture,
          'screen': const GeometryCalculatorScreen(),
          'color': Colors.blue,
        },
        {
          'title': 'Diskon',
          'icon': Icons.discount,
          'screen': const DiscountCalculatorScreen(),
          'color': Colors.red,
        },
      ],
    },
    {
      'title': 'Kesehatan',
      'items': [
        {
          'title': 'BMI',
          'icon': Icons.monitor_weight,
          'screen': const BmiCalculatorScreen(),
          'color': Colors.purple,
        },
        {
          'title': 'Kesehatan',
          'icon': Icons.favorite,
          'screen': const HealthCalculatorScreen(),
          'color': Colors.pink,
        },
        {
          'title': 'Target\nZona',
          'icon': Icons.monitor_heart,
          'screen': const TargetZoneCalculatorScreen(),
          'color': Colors.red,
        },
        {
          'title': 'Pace\nLari',
          'icon': Icons.directions_run,
          'screen': const PaceCalculatorScreen(),
          'color': Colors.green,
        },
        {
          'title': 'One Rep\nMax',
          'icon': Icons.fitness_center,
          'screen': const OneRepMaxCalculatorScreen(),
          'color': Colors.deepPurple,
        },
        {
          'title': 'IMT\nDetail',
          'icon': Icons.accessibility_new,
          'screen': const DetailedBmiCalculatorScreen(),
          'color': Colors.teal,
        },
      ],
    },
    {
      'title': 'Finansial',
      'items': [
        {
          'title': 'Finansial',
          'icon': Icons.attach_money,
          'screen': const FinancialCalculatorScreen(),
          'color': Colors.pink,
        },
        {
          'title': 'Zakat',
          'icon': Icons.mosque,
          'screen': const ZakatCalculatorScreen(),
          'color': Colors.green,
        },
        {
          'title': 'Pajak\nPenghasilan',
          'icon': Icons.receipt_long,
          'screen': const IncomeTaxCalculatorScreen(),
          'color': Colors.blue,
        },
        {
          'title': 'Dana\nPensiun',
          'icon': Icons.elderly,
          'screen': const RetirementCalculatorScreen(),
          'color': Colors.purple,
        },
        {
          'title': 'Dana\nDarurat',
          'icon': Icons.savings,
          'screen': const EmergencyFundCalculatorScreen(),
          'color': Colors.orange,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                _pages[_selectedIndex]['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.85,
                    children: [
                      ..._pages[_selectedIndex]['items'].map(
                        (item) => _buildMenuCard(
                          context,
                          item['title'],
                          item['icon'],
                          item['screen'],
                          item['color'],
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Konversi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Matematika',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Kesehatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Finansial',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget destination,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.8),
                  color,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
