part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return const _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: size.height * 0.07,
          left: size.width * 0.05,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 300),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -15),
            child: BounceInDown(
              child: Icon(Icons.location_on, size: size.width * 0.1),
            ),
          ),
        ),

        //Boton confirmar destino
        Positioned(
          bottom: size.height * 0.07,
          left: size.width * 0.15,
          child: FadeIn(
            child: MaterialButton(
              minWidth: size.width - size.width * 0.4,
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                calcularDestino(context);
              },
              child: const Text(
                'Confirmar Destino',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlerta(context);
    final trafficService = TrafficService();
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = mapaBloc.state.ubicacionCentral;

    final trafficResponse = await trafficService.getCoordsInicioYFin(inicio!, destino!);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;

    //Decodificar los puntos de Geometry
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    final List<LatLng> rutaCoords = points
        .map(
          (point) => LatLng(point[0], point[1]),
        )
        .toList();

    mapaBloc.add(OnCrearRutaInicioDestinoMapa(rutasCoordenadas: rutaCoords, distancia: distance, duracion: duration));

    Navigator.of(context).pop();
    BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
  }
}
