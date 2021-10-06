import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:app_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:app_mapas/bloc/busqueda/busqueda_bloc.dart';

import 'package:app_mapas/services/traffic_service.dart';

import 'package:app_mapas/helpers/helpers.dart';

import 'package:app_mapas/models/search_result.dart';

import 'package:app_mapas/search/search_destination.dart';

import 'package:animate_do/animate_do.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline_do/polyline_do.dart' as Poly;

part 'btn_ubicacion.dart';
part 'btn_mi_ruta.dart';
part 'btn_seguir_ruta.dart';
part 'searchbar.dart';
part 'marcador_manual.dart';
