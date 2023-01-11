import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/blocs/blocs.dart';
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
      emit(state.copywith(polylinesC: event.polylines));
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

        final myRoute= Polyline(
          polylineId:  PolylineId('Route'),
          width: 5,
          color: Colors.grey,
          points: destination.points,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          );


  final currentPolylines=Map<String, Polyline>.from(state.polylines);
  currentPolylines['Route']=myRoute;
  add(DisplayPolylineEvent(currentPolylines));



  }


    @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
