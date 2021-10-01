import 'package:app_mapas/pages/acceso_gps_page.dart';
import 'package:app_mapas/pages/loading_page.dart';
import 'package:app_mapas/pages/mapa_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
      routes: {
        'mapa': (_) => MapaPage(),
        'loading': (_) => const LoadingPage(),
        'acceso_gps': (_) => const AccesoGpsPage(),
      },
    );
  }
}
