import 'package:flutter/material.dart';
import 'dart:math' as math;

class CalorieCalculatorPage extends StatefulWidget {
  @override
  _CalorieCalculatorPageState createState() => _CalorieCalculatorPageState();
}

// Custom painter untuk membuat gauge
class CalorieGaugePainter extends CustomPainter {
  final double value;
  final double maxValue;

  CalorieGaugePainter({required this.value, this.maxValue = 3000});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.7); // Letakkan lebih rendah
    final radius = size.width * 0.3; // Perkecil radius

    // Background arc (grey)
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15; // Kurangi lebar stroke

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Calculate color based on value
    Color gaugeColor;
    if (value < maxValue * 0.5) {
      gaugeColor = Colors.yellow;
    } else if (value < maxValue * 0.75) {
      gaugeColor = Colors.green;
    } else {
      gaugeColor = Colors.red;
    }

    // Value arc
    final valuePaint = Paint()
      ..color = gaugeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 // Kurangi lebar stroke
      ..strokeCap = StrokeCap.round;

    final valueAngle = (value / maxValue) * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      valueAngle,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  String _gender = 'Pria';
  double _weight = 0;
  double _height = 0;
  int _age = 0;
  String _activityLevel = 'Sedentary';
  double _calories = 0;

  final Map<String, double> _activityMultipliers = {
    'Sedentary': 1.2,
    'Light': 1.375,
    'Moderate': 1.55,
    'Active': 1.725,
    'Very Active': 1.9,
  };

  void _calculateCalories() {
    double bmr;

    if (_gender == 'Pria') {
      bmr = 88.362 + (13.397 * _weight) + (4.799 * _height) - (5.677 * _age);
    } else {
      bmr = 447.593 + (9.247 * _weight) + (3.098 * _height) - (4.330 * _age);
    }

    setState(() {
      _calories = bmr * _activityMultipliers[_activityLevel]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Kalori'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Pria'),
                    value: 'Pria',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Wanita'),
                    value: 'Wanita',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Berat Badan (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Tinggi Badan (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _height = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Usia (tahun)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Tingkat Aktivitas',
                border: OutlineInputBorder(),
              ),
              value: _activityLevel,
              items: _activityMultipliers.keys.map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _activityLevel = value!;
                });
              },
            ),
            SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _calculateCalories,
              child: Text('Hitung Kalori'),
            ),
            SizedBox(height: 24),

            if (_calories > 0)
              AspectRatio(
                aspectRatio: 1.5,
                child: CustomPaint(
                  painter: CalorieGaugePainter(value: _calories),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_calories.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Calories',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'To start losing weight',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
