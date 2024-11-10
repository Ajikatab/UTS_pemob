import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/foto.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Faturohman Fahrizi Katab',
            style: TextStyle(fontSize: 20, FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '152022072',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        )
      ),
    );
  }
}