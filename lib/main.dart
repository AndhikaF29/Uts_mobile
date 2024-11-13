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
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Multi Calculator',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2A2D3E),
              primary: const Color(0xFF2A2D3E),
              secondary: const Color(0xFF6C63FF),
            ),
            useMaterial3: true,
            fontFamily: 'Poppins',
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2A2D3E),
              primary: const Color(0xFF2A2D3E),
              secondary: const Color(0xFF6C63FF),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            fontFamily: 'Poppins',
          ),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const MyHomePage(),
            '/zakat-calculator': (context) => const ZakatCalculatorScreen(),
            '/income-tax-calculator': (context) =>
                const IncomeTaxCalculatorScreen(),
            '/retirement-calculator': (context) =>
                const RetirementCalculatorScreen(),
            '/emergency-fund-calculator': (context) =>
                const EmergencyFundCalculatorScreen(),
          },
        );
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
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildPage(_pages[0]), // Konversi
          _buildPage(_pages[1]), // Matematika
          _buildPage(_pages[2]), // Kesehatan
          _buildPage(_pages[3]), // Finansial
        ],
      ),
      extendBody: true, // Penting untuk bottom bar yang transparan
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        notchColor: const Color.fromARGB(255, 37, 211, 255),
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        kBottomRadius: 28.0,
        kIconSize: 24,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.swap_horiz_rounded,
              color: Colors.grey[600],
            ),
            activeItem: const Icon(
              Icons.swap_horiz_rounded,
              color: Colors.white,
            ),
            itemLabel: 'Konversi',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.calculate_rounded,
              color: Colors.grey[600],
            ),
            activeItem: const Icon(
              Icons.calculate_rounded,
              color: Colors.white,
            ),
            itemLabel: 'Matematika',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite_rounded,
              color: Colors.grey[600],
            ),
            activeItem: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
            ),
            itemLabel: 'Kesehatan',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.grey[600],
            ),
            activeItem: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
            ),
            itemLabel: 'Finansial',
          ),
        ],
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> pageData) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDarkMode ? Colors.black : const Color(0xFF2A2D3E),
            isDarkMode
                ? Colors.black.withOpacity(0.8)
                : const Color(0xFF2A2D3E).withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        pageData['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.asset(
                        'assets/profile.jpg',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Content Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: [
                    ...pageData['items'].map(
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
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget destination,
    Color color,
  ) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? color.withOpacity(0.3) : color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.9),
                  color,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 30,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
