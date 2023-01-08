import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/ui/ui.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc= BlocProvider.of<LocationBloc>(context);
    final mapBloc= BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location_outlined,color: Colors.black,),
          onPressed: () {
            final userLocation= locationBloc.state.lastKnowLocation;

             if(userLocation == null) {
             final snack= CustomSnackBar(message: 'No hay ubicacion');
              ScaffoldMessenger.of(context).showSnackBar(snack);
                return ;
             }

            mapBloc.moveCamera(userLocation!);


          },
        ),
      ),
    );
  }
}