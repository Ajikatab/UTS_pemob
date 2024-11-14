// temperature_converter_page.dart
import 'package:flutter/material.dart';

class TemperatureConverterPage extends StatefulWidget {
  @override
  _TemperatureConverterPageState createState() => _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  double? inputTemperature;
  String fromUnit = 'Celsius';
  String toUnit = 'Fahrenheit';
  double? result;
  final TextEditingController _controller = TextEditingController();

  final List<String> units = ['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur'];

  void convert() {
    if (inputTemperature == null) return;

    setState(() {
      // Konversi ke Celsius terlebih dahulu
      double celsius;
      switch (fromUnit) {
        case 'Celsius':
          celsius = inputTemperature!;
          break;
        case 'Fahrenheit':
          celsius = (inputTemperature! - 32) * 5 / 9;
          break;
        case 'Kelvin':
          celsius = inputTemperature! - 273.15;
          break;
        case 'Reamur':
          celsius = inputTemperature! * 5 / 4;
          break;
        default:
          celsius = inputTemperature!;
      }

      // Konversi dari Celsius ke unit yang diinginkan
      switch (toUnit) {
        case 'Celsius':
          result = celsius;
          break;
        case 'Fahrenheit':
          result = (celsius * 9 / 5) + 32;
          break;
        case 'Kelvin':
          result = celsius + 273.15;
          break;
        case 'Reamur':
          result = celsius * 4 / 5;
          break;
        default:
          result = celsius;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input suhu
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Masukkan Suhu',
                    border: OutlineInputBorder(),
                    hintText: 'Contoh: 32.5',
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputTemperature = double.tryParse(value);
                    });
                  },
                ),
                SizedBox(height: 20),

                // Unit asal
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: fromUnit,
                      items: units.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            fromUnit = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),

                // Icon panah
                Icon(Icons.arrow_downward, size: 40, color: Colors.blue),

                // Unit tujuan
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: toUnit,
                      items: units.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            toUnit = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
                
                SizedBox(height: 20),

                // Tombol konversi
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (inputTemperature != null) {
                      convert();
                    }
                  },
                  child: Text(
                    'Konversi',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                SizedBox(height: 20),

                // Hasil konversi
                if (result != null)
                  Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Hasil Konversi:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${result!.toStringAsFixed(2)}° $toUnit',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Rumus yang digunakan
                SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rumus yang digunakan:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(_getFormula(),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
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
      ),
    );
  }

  String _getFormula() {
    if (fromUnit == toUnit) return 'Nilai tetap sama';

    Map<String, Map<String, String>> formulas = {
      'Celsius': {
        'Fahrenheit': '°F = °C × 9/5 + 32',
        'Kelvin': 'K = °C + 273.15',
        'Reamur': '°R = °C × 4/5',
      },
      'Fahrenheit': {
        'Celsius': '°C = (°F - 32) × 5/9',
        'Kelvin': 'K = (°F - 32) × 5/9 + 273.15',
        'Reamur': '°R = (°F - 32) × 4/9',
      },
      'Kelvin': {
        'Celsius': '°C = K - 273.15',
        'Fahrenheit': '°F = (K - 273.15) × 9/5 + 32',
        'Reamur': '°R = (K - 273.15) × 4/5',
      },
      'Reamur': {
        'Celsius': '°C = °R × 5/4',
        'Fahrenheit': '°F = °R × 9/4 + 32',
        'Kelvin': 'K = °R × 5/4 + 273.15',
      },
    };

    return formulas[fromUnit]?[toUnit] ?? 'Formula tidak tersedia';
  }
}