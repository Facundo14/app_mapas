part of 'widgets.dart';

class BtnSeguirRuta extends StatelessWidget {
  const BtnSeguirRuta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) => _crearBoton(context, state, size),
    );
  }

  Widget _crearBoton(BuildContext context, MapaState state, Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            state.seguirUbicacion ? Icons.directions_run : Icons.accessibility_new,
            color: Colors.black87,
          ),
          onPressed: () {
            final mapaBloc = BlocProvider.of<MapaBloc>(context);
            mapaBloc.add(OnSeguirUbicacionMapa());
          },
        ),
      ),
    );
  }
}
