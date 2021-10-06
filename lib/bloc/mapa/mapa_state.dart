part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng? ubicacionCentral;

  //Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapaState({
    this.dibujarRecorrido = false,
    this.mapaListo = false,
    polylines,
    markers,
    this.seguirUbicacion = false,
    this.ubicacionCentral,
  })  : polylines = polylines ?? {},
        markers = markers ?? {};

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    bool? seguirUbicacion,
    LatLng? ubicacionCentral,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        polylines: polylines ?? this.polylines,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
        markers: markers ?? this.markers,
      );
}
