import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/models/models.dart';
import 'package:rutas_app/services/services.dart';


class TrafficServices{

final Dio _dioTraffic;


final String _baseTrafficUrl='https://api.mapbox.com/directions/v5/mapbox';

TrafficServices() : _dioTraffic=Dio()..interceptors.add(TrafficInterceptor());


Future<TrafficResponse> getCoordsStartToEnd(LatLng start, LatLng end ) async {



  final  coordsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

  final url= '$_baseTrafficUrl/driving/$coordsString';

  final res= await _dioTraffic.get(url);

  final data= TrafficResponse.fromJson(res.data);
  

  return data;
}





}