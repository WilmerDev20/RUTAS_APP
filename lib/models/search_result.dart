

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {

  final bool cancel;

  final bool? manual;

  final LatLng? position;

  final String? name;
  
  final String? description;

  

  //Nombre del destino, descripcion, latlg

  SearchResult({
    required this.cancel,
    this.manual= false,
    this.name,
    this.position,
    this.description
    
  });

 @override
String toString() { 

  return 'cancel : $cancel - manual: $manual';
}

}