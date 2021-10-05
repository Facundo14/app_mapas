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
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, MiUbicacionState state) => crearMapa(state),
          ),

          //TODO: hacer el toggle cuando estoy manualmente
          Positioned(top: size.height * 0.01, child: const SearchBar()),
          const MarcadorManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnUbicacion(),
          BtnSeguirRuta(),
          BtnMiRuta(),
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) return const Center(child: CircularProgressIndicator());

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnUbicacionCambioMapa(ubicacion: state.ubicacion!));
    final cameraPosition = CameraPosition(
      target: state.ubicacion!,
      zoom: 15,
    );

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          //onMapCreated: (GoogleMapController controller) => mapaBloc.initMapa(controller),
          onMapCreated: mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(centroMapa: cameraPosition.target));
          },
        );
      },
    );
  }
}
