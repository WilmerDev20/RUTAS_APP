import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/models/models.dart';
import 'package:rutas_app/services/services.dart';


class TrafficServices{

final Dio _dioTraffic;
final Dio _dioPlaces;


final String _baseTrafficUrl='https://api.mapbox.com/directions/v5/mapbox';
final String _basePlacesUrl='https://api.mapbox.com/geocoding/v5/mapbox.places';

TrafficServices() 
: _dioTraffic=Dio()..interceptors.add(TrafficInterceptor()),
 _dioPlaces=Dio()..interceptors.add(PlacesInterceptor());


Future<TrafficResponse> getCoordsStartToEnd(LatLng start, LatLng end ) async {
  final  coordsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

  final url= '$_baseTrafficUrl/driving/$coordsString';

  final res= await _dioTraffic.get(url);

  final data= TrafficResponse.fromJson(res.data);
  
  return data;
}


Future <List<Feature?>> getResultsByQuery(LatLng proximity ,String query)async{


  if(query.isEmpty) return[];


  final url ='$_basePlacesUrl/$query.json';



 
    
  final resp = await _dioPlaces.get(url,queryParameters: {
    'proximity':'${proximity.longitude},${proximity.latitude}',
    'limit':7
  });

  final placesResponse= PlacesResponse.fromMap(resp.data);

  return placesResponse.features;


}



Future <Feature> getInformationByCoords(LatLng coords) async{

final url ='$_basePlacesUrl/${coords.longitude},${coords.latitude}.json';

final resp= await _dioPlaces.get(url,queryParameters: {
  'limit':1,
});

final placesResponse= PlacesResponse.fromMap(resp.data);

return placesResponse.features[0]!;


}





}