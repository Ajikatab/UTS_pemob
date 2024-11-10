import 'package:flutter/material.dart';
import 'splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Utama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Serba Guna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Menampilkan dalam dua kolom
          crossAxisSpacing: 16, // Jarak horizontal antar tombol
          mainAxisSpacing: 16, // Jarak vertikal antar tombol
          children: <Widget>[
            _buildMenuButton(context, 'Kalkulator Umum', Icons.calculate, Colors.teal, () {
              // Navigasi ke halaman kalkulator umum
            }),
            _buildMenuButton(context, 'Kalkulator BMI', Icons.monitor_weight, Colors.purple, () {
              // Navigasi ke halaman kalkulator BMI
            }),
            _buildMenuButton(context, 'Konversi Suhu', Icons.thermostat, Colors.orange, () {
              // Navigasi ke halaman konversi suhu
            }),
            _buildMenuButton(context, 'Kalkulator Persentase', Icons.percent, Colors.green, () {
              // Navigasi ke halaman kalkulator persentase
            }),
            _buildMenuButton(context, 'Kalkulator Waktu/Durasi', Icons.timer, Colors.blue, () {
              // Navigasi ke halaman kalkulator waktu
            }),
            _buildMenuButton(context, 'Kalkulator Nutrisi Kalori', Icons.fastfood, Colors.red, () {
              // Navigasi ke halaman kalkulator nutrisi kalori
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Colors.white),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
      ),
      body: Center(
        child: Text('halaman Kalkulator'),
      ),
    );
  }
}

class BmiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI'),
      ),
      body: Center(
        child: Text('Halaman BMI'),
      ),
    );
  }
}

class TemperatureConververterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
      ),
      body: Center(
        child: Text('Halaman Konversi suhu'),
      ), 
    );
  }
}

class PercentageCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Persentase'),
      ),
      body: Center(
        child: Text('Halaman Kalkulator Persentase'),
      ),
    );
  }
}

class TimeDurationCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Waktu'),
      ),
      body: Center(
        child: Text('Halaman Kalkulator Waktu'),
      ),
    );
  }
}

class NutritionCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkultor Nutrisi Kalori'),
      ),
      body: Center(
        child: Text('Halaman Kalkulator Kalori'),
      ),
    );
  }
}