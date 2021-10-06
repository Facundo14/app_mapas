part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng ubicacion;

  const MiUbicacionState({this.siguiendo = true, this.existeUbicacion = false, ubicacion}) : ubicacion = ubicacion ?? const LatLng(0, 0);

  MiUbicacionState copyWith({
    bool? siguiendo,
    bool? existeUbicacion,
    LatLng? ubicacion,
  }) =>
      MiUbicacionState(
        siguiendo: siguiendo ?? this.siguiendo,
        existeUbicacion: existeUbicacion ?? this.existeUbicacion,
        ubicacion: ubicacion ?? this.ubicacion,
      );
}
