part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'assets/custom-pin.png',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );

  final bytes = resp.data;

  //Opcional para cambiar la resolucion de la imagen

  final imageCodec = await instantiateImageCodec(bytes, targetHeight: 150, targetWidth: 150);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
