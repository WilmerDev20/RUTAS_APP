import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsStreamSubscription;

  GpsBloc() : super(GpsState(isGpsEnable: false,isGpsPermissionGranted: false)) {



    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      gpsEnable: event.isGpsEnable,
      gpsPermissionGranted: event.isGpsPermissionGranted
    ))
    );
    _init();
  }


  Future<void> _init()async{
    
    final gpsInitStatus = await Future.wait([
        _checkGPSStatus(),
        _isPermissionGranted()
    ]);

    add(GpsAndPermissionEvent(
      gpsInitStatus[0], //Is gpsEnable
      gpsInitStatus[1]//isGpsPermissionGranted
    ));

  }

  Future<bool>_isPermissionGranted()async{
    final isGranted= Permission.location.isGranted;
    return isGranted;
  }






  Future<bool> _checkGPSStatus()async{
    final isEnable= await Geolocator.isLocationServiceEnabled();

    gpsStreamSubscription=Geolocator.getServiceStatusStream().listen((event) {
      final isEnable=(event.index == 1) ? true : false;
      print('SERVICE status $isEnable');
      
     add(GpsAndPermissionEvent(
      isEnable,
      state.isGpsPermissionGranted));

     
    });



    return isEnable;

  }

  Future<void>askGpsAccess() async {
    final status= await Permission.location.request();
    
    switch(status){
      
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(state.isGpsEnable, true));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(state.isGpsEnable, false));
      openAppSettings();
    }

  }


  @override
  Future<void> close() {
    gpsStreamSubscription?.cancel();// ? si tienes un valor cancelalo sino no hagas nada
    return super.close();
  }





}
