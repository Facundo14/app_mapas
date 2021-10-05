part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          return FadeInDown(
            duration: const Duration(milliseconds: 300),
            child: buildSearchbar(context),
          );
        }
      },
    );
  }

  Widget buildSearchbar(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        width: size.width,
        child: GestureDetector(
          onTap: () async {
            final proximidad = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
            final historial = BlocProvider.of<BusquedaBloc>(context).state.historial;

            final resultado = await showSearch(
              context: context,
              delegate: SearchDestination(proximidad: proximidad!, historial: historial),
            );
            retornoBusqueda(context, resultado!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.013),
            width: size.width,
            child: const Text(
              '¿Donde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(3, 5),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) async {
    if (result.cancelo) return;

    if (result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }

    calculandoAlerta(context);

    //Calcular la ruta en base al valor del result;

    final trafficService = TrafficService();
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = result.position;

    final drivingResponse = await trafficService.getCoordsInicioYFin(inicio!, destino!);

    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

    final List<LatLng> rutaCoordenadas = points.decodedCoords
        .map(
          (point) => LatLng(point[0], point[1]),
        )
        .toList();

    mapaBloc.add(OnCrearRutaInicioDestinoMapa(rutasCoordenadas: rutaCoordenadas, distancia: distance, duracion: duration));

    Navigator.of(context).pop();

    // Agregar al historial
    final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    busquedaBloc.add(OnAgregarHistorial(result: result));
  }
}
