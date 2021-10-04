part of 'widgets.dart';

class BtnMiRuta extends StatelessWidget {
  const BtnMiRuta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.alt_route_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            mapaBloc.add(OnMarcarRutaMapa());
          },
        ),
      ),
    );
  }
}
