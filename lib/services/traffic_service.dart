import 'dart:async';

import 'package:app_mapas/helpers/debouncer.dart';
import 'package:app_mapas/models/reverse_query_response.dart';
import 'package:app_mapas/models/search_respose.dart';
import 'package:dio/dio.dart';
import 'package:app_mapas/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer = Debouncer<String>(duration: const Duration(milliseconds: 400));

  final StreamController<SearchResponse> _sugerenciasStreamController = StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get sugerenciasStream => _sugerenciasStreamController.stream;

  final String _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final String _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final String _apiKey = 'pk.eyJ1IjoiZmFjdXgxNCIsImEiOiJja3VjcWo5bDMxMzlxMnFxcGdid3U2c2l1In0.GqIRFnaGIMAhk7ii9QMgfw';

  Future<TrafficResponse> getCoordsInicioYFin(LatLng inicio, LatLng destino) async {
    final coordString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';

    final url = '$_baseUrlDir/mapbox/driving/$coordString';

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

  Future<SearchResponse> getResultadosPorQuery(String busqueda, LatLng proximidad) async {
    final url = '$_baseUrlGeo/mapbox.places/$busqueda.json';

    try {
      final resp = await _dio.get(
        url,
        queryParameters: {
          'access_token': _apiKey,
          'autocomplete': 'true',
          'proximity': '${proximidad.longitude},${proximidad.latitude}',
          'language': 'es',
        },
      );
      final searchResponse = searchResponseFromJson(resp.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await getResultadosPorQuery(value, proximidad);
      _sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(const Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ReverseQueryResponse> getCoordenadasInfo(LatLng destinoCoords) async {
    final url = '$_baseUrlGeo/mapbox.places/${destinoCoords.longitude},${destinoCoords.latitude}.json';

    try {
      final resp = await _dio.get(
        url,
        queryParameters: {
          'access_token': _apiKey,
          'language': 'es',
        },
      );
      final reversequeryesponse = reverseQueryResponseFromJson(resp.data);
      return reversequeryesponse;
    } catch (e) {
      return ReverseQueryResponse(features: []);
    }
  }
}
