import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/ui/ui.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapaBloc,MapaState>(

          builder: (context, state) {
            return IconButton(
              icon: Icon(state.isFollowingUser? Icons.directions_run_rounded : Icons.hail_rounded, color: Colors.black,
              ),
              onPressed: () {

                mapBloc.add(OnStartFollowingUserEvent());



              },
            );
          },
        ),
      ),
    );
  }
}
