import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/screens/screens.dart';

import 'blocs/blocs.dart';

void main()  {
  runApp(MultiBlocProvider(providers: [
     BlocProvider(create: (context) => GpsBloc(),),
     BlocProvider(create: (context) => LocationBloc(),),
     BlocProvider(create: (context) => MapaBloc(),),



  ], child: const MyApp()));}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: LoadingScreen().ruta,
      routes: {
        GpsAccessScreen().ruta :(context) =>GpsAccessScreen(),
        MapScreen().ruta :(context) =>MapScreen(),
        LoadingScreen().ruta :(context) =>LoadingScreen(),

      },

    );
  }
}


