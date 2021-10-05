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
            final resultado = await showSearch(
              context: context,
              delegate: SearchDestination(),
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

  void retornoBusqueda(BuildContext context, SearchResult result) {
    if (result.cancelo) return;

    if (result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }
}
