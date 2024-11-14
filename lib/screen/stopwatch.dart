// stopwatch.dart
import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool isRunning = false;
  double dialSize = 300;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formattedTime() {
    var milliseconds = _stopwatch.elapsedMilliseconds;
    var hundreds = (milliseconds / 10).floor() % 100;
    var seconds = (milliseconds / 1000).floor() % 60;
    var minutes = (milliseconds / 60000).floor();
    
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundreds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stopwatch dial
            Container(
              width: dialSize,
              height: dialSize,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Dial markings
                  ...List.generate(60, (index) {
                    final angle = index * 6.0 * (3.14159 / 180);
                    final length = index % 5 == 0 ? 15.0 : 8.0;
                    return Transform.rotate(
                      angle: angle,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: length,
                          width: 2,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10),
                        ),
                      ),
                    );
                  }),
                  
                  // Hand
                  Transform.rotate(
                    angle: _stopwatch.elapsedMilliseconds * 0.006283185 * 0.1,
                    child: Container(
                      height: dialSize * 0.4,
                      width: 3,
                      color: Colors.orange,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ],
              ),
            ),
            
            // Time display
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                _formattedTime(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            
            // Control buttons
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _stopwatch.reset();
                        isRunning = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                      backgroundColor: Colors.grey[800],
                    ),
                    child: Text('Reset', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_stopwatch.isRunning) {
                          _stopwatch.stop();
                        } else {
                          _stopwatch.start();
                        }
                        isRunning = _stopwatch.isRunning;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      isRunning ? 'Stop' : 'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}