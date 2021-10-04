part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnUbicacionCambioMapa extends MapaEvent {
  final LatLng ubicacion;

  OnUbicacionCambioMapa({required this.ubicacion});
}

class OnMarcarRutaMapa extends MapaEvent {}

class OnSeguirUbicacionMapa extends MapaEvent {}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;

  OnMovioMapa({required this.centroMapa});
}
