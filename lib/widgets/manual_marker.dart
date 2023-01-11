import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/helpers/helpers.dart';


class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {

        return state.displayManualMarker 
        ? _ManualMarkerBody()
        :const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    final searchBloc= BlocProvider.of<SearchBloc>(context);
    final locationBloc=BlocProvider.of<LocationBloc>(context);
    final mapBloc=BlocProvider.of<MapaBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children:  [
          
          Positioned(
            top: 70,
            left: 20,
            child: _btnBack()       
          ),
          Center(
            child: Transform.translate(
              offset: Offset(0,-22),
              child: BounceInDown(
                from: 100,
                child: 
                Icon(Icons.location_on_rounded,size: 60,color: Colors.white,)),
            ),),
          //Boton de confirmar
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width -120,   
                onPressed: ()async{
                  
                  //Loading

                  final start=locationBloc.state.lastKnowLocation;
                  if(start ==null) return ;

                  final end= mapBloc.mapCenter;
                  if(end==null) return ;

                  showLoadingMessage(context);

                  final destination=await searchBloc.getCoordsStartToEnd(start, end);

                    await mapBloc.drawRoutePolyline(destination);

                  searchBloc.add(OnDesactivateManualMarkerEvent());
                  Navigator.pop(context);



                },
                color: Colors.white,
                elevation: 0,
                height: 50,
                shape: StadiumBorder(),
                child: Text('Confirmar destino',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            
            
              ),
            ))



        ],
      ),
    );
  }
}

class _btnBack extends StatelessWidget {
  const _btnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc= BlocProvider.of<SearchBloc>(context);
    return FadeInLeft(
      duration: Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: (){
            searchBloc.add(OnDesactivateManualMarkerEvent());
          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),
    
        ),
      ),
    );
  }
}