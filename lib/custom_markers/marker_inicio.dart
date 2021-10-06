part of 'custom_markers.dart';

class MarkerInicioPainter extends CustomPainter {
  final int minutos;

  MarkerInicioPainter(this.minutos);
  @override
  void paint(Canvas canvas, Size size) {
    final double tamanoCirculoNegro = size.height * 0.14;
    final double radioCirculoNegro = size.width * 0.06;
    final double radioCirculoBlanco = size.width * 0.02;
    Paint paint = Paint()..color = Colors.black;

    //Dibujar circulo Negro
    canvas.drawCircle(
      Offset(tamanoCirculoNegro, size.height - tamanoCirculoNegro),
      radioCirculoNegro,
      paint,
    );

    //Ciruclo Blanco
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(tamanoCirculoNegro, size.height - tamanoCirculoNegro),
      radioCirculoBlanco,
      paint,
    );

    final Path path = Path();

    path.moveTo(size.width * 0.1128571, size.height * 0.1336000);
    path.lineTo(size.width * 0.8862571, size.height * 0.1531333);
    path.lineTo(size.width * 0.8858000, size.height * 0.7028000);
    path.lineTo(size.width * 0.1140571, size.height * 0.7003333);
    path.lineTo(size.width * 0.1128571, size.height * 0.1536000);
    path.close();

    canvas.drawShadow(path, Colors.black87, 10, false);

    //Caja Blanca
    final cajaBlanca =
        Rect.fromLTWH(size.width * 0.1328571, size.height * 0.1436000, size.width - size.width * 0.23, size.height * 0.5368000);

    canvas.drawRect(cajaBlanca, paint);

    //Caja Negra
    paint.color = Colors.black;
    final cajaNegra =
        Rect.fromLTWH(size.width * 0.1328571, size.height * 0.1436000, size.width - size.width * 0.75, size.height * 0.5368000);

    canvas.drawRect(cajaNegra, paint);

    // Dibujar Textos
    TextSpan textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.075,
        fontWeight: FontWeight.w400,
      ),
      text: '$minutos',
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: size.width * 0.3,
        maxWidth: size.width * 0.3,
      );

    textPainter.paint(canvas, Offset(size.width * 0.1, size.width * 0.1));

    //Minutos
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.06,
        fontWeight: FontWeight.w400,
      ),
      text: 'Min',
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: size.width * 0.3,
        maxWidth: size.width * 0.3,
      );

    textPainter.paint(canvas, Offset(size.width * 0.1, size.width * 0.2));

    //Mi ubicacion
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: size.width * 0.065,
        fontWeight: FontWeight.w400,
      ),
      text: 'Mi ubicación',
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: size.width - size.width * 0.3);

    textPainter.paint(canvas, Offset(size.width * 0.45, size.width * 0.145));
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}
