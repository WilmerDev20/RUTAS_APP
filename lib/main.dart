import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/screens/screens.dart';
import 'package:rutas_app/services/services.dart';

import 'blocs/blocs.dart';

void main()  {
  runApp(MultiBlocProvider(providers: [
     BlocProvider(create: (context) => GpsBloc(),), //el orden es importante si vamos a hacer dependencias de un bloc con otro
     BlocProvider(create: (context) => LocationBloc(),),
     BlocProvider(create: (context) => MapaBloc(locationBloc: BlocProvider.of<LocationBloc>(context)),),
     BlocProvider(create: (context) => SearchBloc(trafficServices: TrafficServices()),),

  ], child: const MyApp()));}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rutas App',
      initialRoute: LoadingScreen().ruta,
      routes: {
        GpsAccessScreen().ruta :(context) =>GpsAccessScreen(),
        MapScreen().ruta :(context) =>MapScreen(),
        LoadingScreen().ruta :(context) =>LoadingScreen(),
        TestMarkerScreen().ruta :(context) =>TestMarkerScreen(),

      },

    );
  }
}


