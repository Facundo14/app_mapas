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

class OnCrearRutaInicioDestinoMapa extends MapaEvent {
  final List<LatLng> rutasCoordenadas;
  final double distancia;
  final double duracion;
  final String nombreDestino;

  OnCrearRutaInicioDestinoMapa({
    rutasCoordenadas,
    this.distancia = 0.0,
    this.duracion = 0.0,
    this.nombreDestino = '',
  }) : rutasCoordenadas = rutasCoordenadas ?? [];
}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;

  OnMovioMapa({required this.centroMapa});
}
