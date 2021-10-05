import 'package:app_mapas/models/traffic_response.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final String _baseUrl = 'https://api.mapbox.com/directions/v5';
  final String _apiKey = 'pk.eyJ1IjoiZmFjdXgxNCIsImEiOiJja3VjcWo5bDMxMzlxMnFxcGdid3U2c2l1In0.GqIRFnaGIMAhk7ii9QMgfw';

  Future<TrafficResponse> getCoordsInicioYFin(LatLng inicio, LatLng destino) async {
    final coordString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';

    final url = '$_baseUrl/mapbox/driving/$coordString';

    final resp = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _apiKey,
      'language': 'es',
    });
    final data = TrafficResponse.fromJson(resp.data);
    return data;
  }
}
