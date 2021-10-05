part of 'helpers.dart';

void calculandoAlerta(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text('Calculando ruta..', textAlign: TextAlign.center),
        content: FittedBox(fit: BoxFit.cover, child: CircularProgressIndicator()),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => const CupertinoAlertDialog(
        title: Text('Calculando ruta..', textAlign: TextAlign.center),
        content: CupertinoActivityIndicator(),
      ),
    );
  }
}
