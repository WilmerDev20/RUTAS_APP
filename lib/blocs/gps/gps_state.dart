part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  bool get isAllGranted=> isGpsEnable && isGpsPermissionGranted;

  const GpsState({required this.isGpsEnable, required this.isGpsPermissionGranted});



  copyWith({
   bool? gpsEnable,
   bool? gpsPermissionGranted})=> GpsState(
    isGpsEnable: gpsEnable ?? isGpsEnable, 
    isGpsPermissionGranted: gpsPermissionGranted ?? isGpsPermissionGranted);
  
  @override
  List<Object> get props => [isGpsEnable,isGpsPermissionGranted];



  @override
  String toString() => '{isGpsEnable : $isGpsEnable, isGpsPermissionGranted : $isGpsPermissionGranted}';
}



