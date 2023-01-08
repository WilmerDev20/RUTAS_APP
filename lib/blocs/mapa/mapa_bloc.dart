import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/themes/themes.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  GoogleMapController?  _mapController;

  MapaBloc() : super(MapaState()) {


    on<OnMapInitialzed>(_onInitMap);



  }
  
    void _onInitMap(OnMapInitialzed event,Emitter<MapaState> emit){

      _mapController=event.controller;

      _mapController!.setMapStyle(jsonEncode(gtaMap));

      emit(state.copywith(isMapInitialized: true));
      
    }

    void moveCamera(LatLng newLocation){
      final cameraUpdate=CameraUpdate.newLatLng(newLocation);

      _mapController?.animateCamera(cameraUpdate);
    }
}
