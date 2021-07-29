import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SplashScreen'),
      ),
      body: Center(
        child: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
              Text(
                'Splash screen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
