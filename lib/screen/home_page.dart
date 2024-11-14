import 'package:flutter/material.dart';
import 'calculator_page.dart';
import 'bmi_page.dart';
import 'temperature_converter_page.dart';
import 'percentage_calculator_page.dart';
import 'stopwatch.dart'; // Mengimpor StopwatchPage
import 'calorie_calculator_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Multi Fungsi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMenuButton(context, 'Kalkulator Sederhana', Icons.calculate, CalculatorPage()),
            _buildMenuButton(context, 'Kalkulator BMI', Icons.monitor_weight, BMICalculator()),
            _buildMenuButton(context, 'Konversi Suhu', Icons.thermostat, TemperatureConverterPage()),
            // _buildMenuButton(context, 'Kalkulator Persentase', Icons.percent, PercentageCalculatorPage()),
            _buildMenuButton(context, 'Stopwatch', Icons.timer, StopwatchPage()), // Mengganti TimeCalculatorPage dengan StopwatchPage
            _buildMenuButton(context, 'Kalkulator Kalori', Icons.local_dining, CalorieCalculatorPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48),
          SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
