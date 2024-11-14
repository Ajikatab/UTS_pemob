import 'package:flutter/material.dart';
import 'dart:math';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  bool _isDarkMode = false;
  String _selectedGender = 'Male';
  double _height = 170.0;
  double _weight = 70.0;
  double _age = 23.0;
  double _bmi = 0.0;
  String _bmiCategory = '';

  void _calculateBMI() {
    setState(() {
      _bmi = _weight / pow((_height / 100), 2);
      _bmiCategory = _getBMICategory(_bmi);
    });
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25.0) {
      return 'Normal';
    } else if (bmi < 30.0) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('BMI Calculator'),
        actions: [
          Switch(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildGenderButton('Male', Icons.male),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: _buildGenderButton('Female', Icons.female),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _buildSlider('Height', _height, 100.0, 220.0, (value) {
              setState(() => _height = value);
            }),
            _buildSlider('Weight', _weight, 40.0, 200.0, (value) {
              setState(() => _weight = value);
            }),
            _buildSlider('Age', _age, 1.0, 100.0, (value) {
              setState(() => _age = value);
            }),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDarkMode ? Colors.blue : Colors.blue.shade300,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16.0),
            _buildBMIDisplay(),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(String gender, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _selectedGender == gender
              ? (_isDarkMode ? Colors.blue : Colors.blue.shade300)
              : (_isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              gender,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: max.toInt() - min.toInt(),
          onChanged: onChanged,
        ),
        Text(
          '${value.toInt()} ${label == 'Height' ? 'cm' : label == 'Weight' ? 'kg' : 'years'}',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBMIDisplay() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your BMI is',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            _bmi.toStringAsFixed(1),
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            _bmiCategory,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}