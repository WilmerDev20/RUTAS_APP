import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
   final String ruta='gps';
  const GpsAccessScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   


    return  Scaffold(
      body: Center( 
          child: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) {
              print('$state');
              return !state.isGpsEnable 
              ? _EnableGpsMessage()
              : _AccessBtn();
            },
          )
      )
    );
  }
}

class _AccessBtn extends StatelessWidget {
  const _AccessBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text('Es necesario el acceso a gps'),
          MaterialButton(
            onPressed: (){

              final gpsBloc = BlocProvider.of<GpsBloc>(context);

              gpsBloc.askGpsAccess();
            },
            color: Colors.black,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 30), 
            child: Text('Solicitar Acceso',style: TextStyle(color: Colors.white),),
            
            
            
            )

        ],
    );
  }
}






class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
       child: Text('Debe de activar el gps ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
    );
  }
}