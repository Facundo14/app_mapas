import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import 'package:app_mapas/helpers/helpers.dart';

import 'package:app_mapas/pages/mapa_page.dart';
import 'package:app_mapas/pages/acceso_gps_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await GeolocatorPlatform.instance.isLocationServiceEnabled()) {
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
        },
      ),
    );
  }

  Future checkGpsYLocation(BuildContext context) async {
    //PermisoGPS
    final permisoGPS = await Permission.location.isGranted;

    //GPS está activo
    final gpsActivo = await GeolocatorPlatform.instance.isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if (!permisoGPS) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, const AccesoGpsPage()));
      return 'Es necesario el permiso del GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
