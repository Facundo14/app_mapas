import 'package:app_mapas/models/search_result.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState()) {
    on<OnActivarMarcadorManual>(_onActivarMarcadorManual);
    on<OnDesactivarMarcadorManual>(_onDesactivarMarcadorManual);
    on<OnAgregarHistorial>(_onAgregarHistorial);
  }

  _onActivarMarcadorManual(OnActivarMarcadorManual event, Emitter<BusquedaState> emit) {
    emit(state.copyWith(seleccionManual: true));
  }

  _onDesactivarMarcadorManual(OnDesactivarMarcadorManual event, Emitter<BusquedaState> emit) {
    emit(state.copyWith(seleccionManual: false));
  }

  _onAgregarHistorial(OnAgregarHistorial event, Emitter<BusquedaState> emit) {
    final existe = state.historial.where((result) => result.nombreDestino == event.result.nombreDestino).length;
    if (existe == 0) {
      final newHistorial = [...state.historial, event.result];
      emit(state.copyWith(historial: newHistorial));
    }
  }
}
