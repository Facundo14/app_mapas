import 'dart:convert';

import 'package:app_mapas/helpers/helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app_mapas/themes/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState()) {
    on<OnMapaListo>(_onMapaListo);
    on<OnUbicacionCambioMapa>(_onUbicacionCambioMapa);
    on<OnMarcarRutaMapa>(_onMarcarRutaMapa);
    on<OnSeguirUbicacionMapa>(_onSeguirUbicacionMapa);
    on<OnMovioMapa>(_onMovioMapa);
    on<OnCrearRutaInicioDestinoMapa>(_onCrearRutaInicioDestinoMapa);
  }

  //Controlador del Mapa
  GoogleMapController? _mapController;

  //Polylines
  Polyline _miRuta = const Polyline(polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent);
  //Polylines Destino trazado de ruta
  Polyline _miRutaDestino = const Polyline(polylineId: PolylineId('mi_ruta_destino'), width: 4, color: Colors.black87);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      _mapController = controller;

      _mapController?.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    _mapController?.animateCamera(cameraUpdate);
  }

  _onMapaListo(MapaEvent event, Emitter<MapaState> emit) {
    emit(state.copyWith(mapaListo: true));
  }

  _onUbicacionCambioMapa(OnUbicacionCambioMapa event, Emitter<MapaState> emit) {
    if (state.seguirUbicacion) {
      moverCamara(event.ubicacion);
    }
    final List<LatLng> points = [..._miRuta.points, event.ubicacion];
    _miRuta = _miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miRuta;

    emit(state.copyWith(polylines: currentPolylines));
  }

  _onMarcarRutaMapa(OnMarcarRutaMapa event, Emitter<MapaState> emit) {
    (!state.dibujarRecorrido)
        ? _miRuta = _miRuta.copyWith(colorParam: Colors.black87)
        : _miRuta = _miRuta.copyWith(colorParam: Colors.transparent);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miRuta;

    emit(state.copyWith(
      dibujarRecorrido: !state.dibujarRecorrido,
      polylines: currentPolylines,
    ));
  }

  _onSeguirUbicacionMapa(OnSeguirUbicacionMapa event, Emitter<MapaState> emit) {
    if (!state.seguirUbicacion) {
      moverCamara(_miRuta.points[_miRuta.points.length - 1]);
    }
    emit(state.copyWith(seguirUbicacion: !state.seguirUbicacion));
  }

  _onMovioMapa(OnMovioMapa event, Emitter<MapaState> emit) {
    emit(state.copyWith(ubicacionCentral: event.centroMapa));
  }

  _onCrearRutaInicioDestinoMapa(OnCrearRutaInicioDestinoMapa event, Emitter<MapaState> emit) async {
    _miRutaDestino = _miRutaDestino.copyWith(
      pointsParam: event.rutasCoordenadas,
    );

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = _miRutaDestino;

    //IconoInicio
    final iconInicio = await getMarkerInicioIcon(event.duracion.toInt());

    //Marcadores comienzo
    final markerInicio = Marker(
      anchor: const Offset(0.1, 0.9),
      markerId: const MarkerId('inicio'),
      position: event.rutasCoordenadas[0],
      icon: iconInicio,
      // infoWindow: InfoWindow(
      //   title: 'Aqui toy',
      //   snippet: 'Duracion recorrido: ${(event.duracion / 60).floor()} minutos',
      // ),
    );

    //IconoFinal
    //final iconDestino = await getNetworkImageMarker();
    final iconDestino = await getMarkerDestinoIcon(event.nombreDestino, event.distancia.toInt());

    //Marcador final
    double kilometros = event.distancia / 1000;
    kilometros = (kilometros * 100).floorToDouble();
    kilometros = kilometros / 100;
    final markerDestino = Marker(
      anchor: const Offset(0.1, 0.9),
      markerId: const MarkerId('destino'),
      position: event.rutasCoordenadas[event.rutasCoordenadas.length - 1],
      icon: iconDestino,
      // infoWindow: InfoWindow(
      //   title: event.nombreDestino,
      //   snippet: 'Distancia: $kilometros Km',
      // ),
    );

    final Map<String, Marker> newMarkers = {...state.markers};
    newMarkers['inicio'] = markerInicio;
    newMarkers['destino'] = markerDestino;

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      //_mapController!.showMarkerInfoWindow(const MarkerId('inicio'));
      _mapController!.showMarkerInfoWindow(const MarkerId('destino'));
    });

    emit(state.copyWith(
      polylines: currentPolylines,
      markers: newMarkers,
    ));
  }
}
