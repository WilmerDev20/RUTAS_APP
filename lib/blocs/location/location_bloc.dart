import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? streamSuscription;
  
  LocationBloc() : super(LocationState()) {
   

    on<StartFollowingUserEvent>((event, emit) {
      state.copyWith(followingUser: true);

    });

     on<StopFollowingUserEvent>((event, emit) {
      state.copyWith(followingUser: false);

    });


    on<NewLocationEvent>((event, emit) {

      emit(state.copyWith(
        lastKnowLocation:  event.newlocation,
        myLocationHistory:[...state.myLocationHistory,event.newlocation] ));
     
    });
  }
   

  Future getCurrentPosition() async{

    final position= await Geolocator.getCurrentPosition();
       add(NewLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    add(StartFollowingUserEvent());
    
    print('startFollowingUser');
    streamSuscription=Geolocator.getPositionStream().listen((event) { 
      final position=event;

      add(NewLocationEvent(LatLng(position.latitude, position.longitude)));
    });


  }

  void stopFollowingUser(){
     streamSuscription?.cancel();
     add(StopFollowingUserEvent());
     print('stopFollowingUser');
  }


  @override
  Future<void> close() {
      stopFollowingUser();
   
    return super.close();
  }

}

