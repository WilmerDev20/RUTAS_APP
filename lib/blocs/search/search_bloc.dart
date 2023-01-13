import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:rutas_app/models/models.dart';
import 'package:rutas_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  TrafficServices trafficServices;




  SearchBloc({required this.trafficServices}) : super(SearchState()) {
    on<OnActivateManualMarkerEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: true));
    });

    on<OnDesactivateManualMarkerEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: false));
    }); 

    on<OnNewPlacesFoundEvent>((event, emit) {

      emit(state.copyWith(placesC: event.places));

    });


    on<AddToHistoryEvent>((event, emit) => emit(state.copyWith(historyC: [event.place,...state.history])));

  }

  Future<RouteDestination> getCoordsStartToEnd(LatLng start, LatLng end) async{

    final trafficResponse= await trafficServices.getCoordsStartToEnd(start, end);

  //Informacion del destino

  final endPlace= await trafficServices.getInformationByCoords(end);


    final geometry=trafficResponse.routes[0]!.geometry;
    final distance= trafficResponse.routes[0]!.distance;
    final duration= trafficResponse.routes[0]!.duration;


    //Decodificar geometry

    
    final points= decodePolyline(geometry!,accuracyExponent:6);

    final latLngList= points.map((coords) => LatLng(coords[0].toDouble(), coords[1].toDouble())).toList();

    return RouteDestination(
      points: latLngList, 
      duration: duration!, 
      distance: distance!,
      endPlace: endPlace
      );

  }


  Future getPlacesByQuery(LatLng proximity, String query) async{

    final newPlaces = await trafficServices.getResultsByQuery(proximity, query);

    add(OnNewPlacesFoundEvent(newPlaces));
    

  }






}
