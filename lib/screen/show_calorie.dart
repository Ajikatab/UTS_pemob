import 'package:flutter/material.dart';
import 'calorie_gauge.dart'; // Import untuk gauge

class ShowCaloriePage extends StatelessWidget {
  final double calories;

  ShowCaloriePage({required this.calories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Perhitungan Kalori'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: Size(300, 300), // Ukuran custom gauge
              painter: CalorieGaugePainter(value: calories),
            ),
            SizedBox(height: 16),
            Text(
              'Kalori yang dibutuhkan: ${calories.toStringAsFixed(0)} kcal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Ini adalah perkiraan kalori yang dibutuhkan untuk mempertahankan berat badan Anda.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
