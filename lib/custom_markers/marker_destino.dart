part of 'custom_markers.dart';

class MarkerDestinoPainter extends CustomPainter {
  final String descripcion;
  final double metros;

  MarkerDestinoPainter(this.descripcion, this.metros);

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

    path.moveTo(0, size.height * 0.15);
    path.lineTo(size.width * 0.95, size.height * 0.15);
    path.lineTo(size.width * 0.95, size.height * 0.6);
    path.lineTo(0, size.height * 0.6);
    path.close();

    canvas.drawShadow(path, Colors.black87, 9, false);

    //Caja Blanca
    final cajaBlanca = Rect.fromLTWH(0, size.height * 0.1436000, size.width - size.width * 0.05, size.height * 0.5);

    canvas.drawRect(cajaBlanca, paint);

    //Caja Negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, size.height * 0.1436000, size.width - size.width * 0.75, size.height * 0.5);

    canvas.drawRect(cajaNegra, paint);

    // Dibujar Textos
    double kilometros = metros / 1000;
    kilometros = (kilometros * 100).floorToDouble();
    kilometros = kilometros / 100;
    TextSpan textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.075,
        fontWeight: FontWeight.w400,
      ),
      text: '$kilometros',
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: size.width * 0.2,
        maxWidth: size.width * 0.3,
      );

    textPainter.paint(canvas, Offset(size.width * 0.006, size.width * 0.1));

    //Minutos
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.06,
        fontWeight: FontWeight.w400,
      ),
      text: 'Km',
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: size.width * 0.25,
        maxWidth: size.width * 0.25,
      );

    textPainter.paint(canvas, Offset(0, size.width * 0.2));

    //Mi ubicacion
    textSpan = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: size.width * 0.05,
        fontWeight: FontWeight.w400,
      ),
      text: descripcion,
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 3,
      ellipsis: '...',
    )..layout(maxWidth: size.width - size.width * 0.3);

    textPainter.paint(canvas, Offset(size.width * 0.263, size.width * 0.08));
  }

  @override
  bool shouldRepaint(MarkerDestinoPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerDestinoPainter oldDelegate) => false;
}
