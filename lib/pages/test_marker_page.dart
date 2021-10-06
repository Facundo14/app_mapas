import 'package:flutter/material.dart';

import 'package:app_mapas/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  const TestMarkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width * 0.8,
          height: size.height * 0.18,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerDestinoPainter(
              'Mi casa por algun lado del mundo, esta aqui, asdasd asdasd asdasda asdasdasda sd asd as',
              250000,
            ),
          ),
        ),
      ),
    );
  }
}
