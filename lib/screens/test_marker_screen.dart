import 'package:flutter/material.dart';
import 'package:rutas_app/markers/markers.dart';
class TestMarkerScreen extends StatelessWidget {
   final ruta= 'test';
  const TestMarkerScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
         child: Container(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: EndMarkerPainter(
              destination: 'Mi casaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
              kilometers: 45,

            ),
          ),
         ),
          
      ),
    );
  }
}