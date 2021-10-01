import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:app_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:app_mapas/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context, listen: false).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context, listen: false).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (_, MiUbicacionState state) => crearMapa(state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnUbicacion(),
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) return const Center(child: CircularProgressIndicator());

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final cameraPosition = CameraPosition(
      target: state.ubicacion!,
      zoom: 15,
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      //onMapCreated: (GoogleMapController controller) => mapaBloc.initMapa(controller),
      onMapCreated: mapaBloc.initMapa,
    );
  }
}
