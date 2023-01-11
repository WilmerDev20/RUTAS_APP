import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/views/views.dart';
import 'package:rutas_app/widgets/widgets.dart';



class MapScreen extends StatefulWidget {

  final String ruta='map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

    late LocationBloc locationBloc;

   @override
  void initState() {
    
    super.initState();

    locationBloc= BlocProvider.of<LocationBloc>(context);

    // locationBloc.getCurrentPosition();

    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
      locationBloc.stopFollowingUser();
      super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          
          if(locationState.lastKnowLocation==null) return Center(child: Text('No ubicacion,espere porfavor'),);
           
          return  BlocBuilder<MapaBloc, MapaState>(
            builder: (context, mapaState) {



              Map<String, Polyline> polylines = Map.from(mapaState.polylines);

              if(!mapaState.showMyRoute){//! si showMyRoute esta en false entonces haga esto 
                polylines.removeWhere((key, value) => key=='myRoute');
              }


              return SingleChildScrollView(
                      
                      child: Stack(
                          children:  [
                            MapView(
                              initialLocation: LatLng(locationState.lastKnowLocation!.latitude, locationState.lastKnowLocation!.longitude),
                              polylines:polylines.values.toSet(),),
                              SearchBar(),
                              ManualMarker(),
                    
                          //botones...

                          ],
                      ),
                    );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),


        ],
      ),
    );
  }
}