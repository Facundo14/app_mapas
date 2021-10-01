part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            final destino = miUbicacion.state.ubicacion;
            mapaBloc.moverCamara(destino!);
          },
        ),
      ),
    );
  }
}
