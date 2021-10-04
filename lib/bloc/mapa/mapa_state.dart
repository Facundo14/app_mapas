part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng? ubicacionCentral;

  //Polylines
  final Map<String, Polyline> polylines;

  MapaState({this.dibujarRecorrido = false, this.mapaListo = false, polylines, this.seguirUbicacion = false, this.ubicacionCentral})
      : polylines = polylines ?? {};

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    Map<String, Polyline>? polylines,
    bool? seguirUbicacion,
    LatLng? ubicacionCentral,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        polylines: polylines ?? this.polylines,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
      );
}
