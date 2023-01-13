import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/models/models.dart';
import 'package:rutas_app/themes/themes.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';





class MapaBloc extends Bloc<MapaEvent, MapaState> {

  final LocationBloc locationBloc; 
  StreamSubscription<LocationState>? locationStateSubscription;
  GoogleMapController?  _mapController;

  LatLng? mapCenter;

  




  // bloc//
  MapaBloc({required this.locationBloc}) : super(MapaState()) {

    on<OnMapInitialzed>(_onInitMap);

    locationStateSubscription=locationBloc.stream.listen((locationState) {
      
      if(!state.isFollowingUser)return;
      if(locationState.lastKnowLocation == null) return ;

    if(locationState.lastKnowLocation !=null){
      add(UpdateUserPolylineEvent(locationState.myLocationHistory));
    }
      moveCamera(LatLng(locationState.lastKnowLocation!.latitude, locationState.lastKnowLocation!.longitude));
    });

    on<OnStartFollowingUserEvent>(_onStartFollowinUser);


    on<OnStopFollowingUserEvent>((event, emit) {

      emit(state.copywith(isFollowingUser: false));

    });

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);

    on<OnToggleUserRouteEvent>((event, emit) {

    
      emit(state.copywith(showMyRoute:!state.showMyRoute));//! si esta en true, que lo pase a false , o viceversa
    });



    on<DisplayPolylineEvent>((event, emit) {
      emit(state.copywith(polylinesC: event.polylines,markersC: event.markers));
    });





  }//end bloc
  
    void _onInitMap(OnMapInitialzed event,Emitter<MapaState> emit){

      _mapController=event.controller;

      _mapController!.setMapStyle(jsonEncode(gtaMap));

      emit(state.copywith(isMapInitialized: true));
      
    }

    void moveCamera(LatLng newLocation){
      final cameraUpdate=CameraUpdate.newLatLng(newLocation);

      _mapController?.animateCamera(cameraUpdate);
    }




    void _onStartFollowinUser(OnStartFollowingUserEvent event , Emitter<MapaState> emit){
         
    
       emit(state.copywith(isFollowingUser: true));
      if(locationBloc.state.lastKnowLocation == null) return ;
      
      moveCamera(locationBloc.state.lastKnowLocation!);

    }


    void _onPolylineNewPoint(UpdateUserPolylineEvent event , Emitter emit){

        final myRoute= Polyline(
          polylineId:  PolylineId('myRoute'),
          color: Colors.grey,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          points: event.userHistory
          
          );

        final currentPolylines = Map<String, Polyline>.from(state.polylines);
        currentPolylines['myRoute']= myRoute;


        emit(state.copywith(polylinesC: currentPolylines));

    }

    Future drawRoutePolyline(RouteDestination destination)  async{

        
     

      double kms = destination.distance/1000; //kilometros

      kms= (kms * 100).floorToDouble();
      kms /= 100;


      int tripDuration= (destination.duration / 60).floorToDouble().toInt();//minutos a horas

      final startMarkerPin= await getStartCustomMarker(tripDuration, 'Esta es tu posicion');
      final endMarkerPin= await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

        final myRoute= Polyline(
          polylineId:  PolylineId('Route'),
          width: 5,
          color: Colors.grey,
          points: destination.points,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          );


        final startMarker = Marker(
          markerId: MarkerId('start'),
          position: destination.points.first,
           icon: startMarkerPin,
           anchor: Offset(0.06,0.9)
          
          );

          final endMarker = Marker(
          markerId: MarkerId('end'),
          position: destination.points.last,
          icon:endMarkerPin ,

           );




    final currentPolylines=Map<String, Polyline>.from(state.polylines);
    currentPolylines['Route']=myRoute;

  final currentMarkers=Map<String, Marker>.from(state.markers);
  currentMarkers['start']=startMarker;
  currentMarkers['end']=endMarker;

    add(DisplayPolylineEvent(currentPolylines,currentMarkers));

    await Future.delayed(Duration(milliseconds: 300));

    _mapController?.showMarkerInfoWindow(MarkerId('start'));





  }

   
    @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
