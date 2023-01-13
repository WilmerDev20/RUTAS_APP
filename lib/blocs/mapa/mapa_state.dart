part of 'mapa_bloc.dart';

 class MapaState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;

  final bool showMyRoute;



  //PolyLines

  final Map<String, Polyline> polylines;


  //Markers 
  final Map<String, Marker> markers;


  const MapaState( {
     Map<String, Marker>? markers, 
     Map<String, Polyline>? polylines,
     this.isMapInitialized= false,  
     this.isFollowingUser=true,
     this.showMyRoute=false}) 
     : polylines = polylines ?? const {},
      markers = markers ?? const {};
    

  MapaState copywith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylinesC,
    Map<String, Marker>? markersC,

    bool? showMyRoute

  }
  ) => MapaState(
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    polylines: polylinesC ?? polylines,
    markers: markersC ?? markers,
    showMyRoute: showMyRoute?? this.showMyRoute
  );


    @override
  List<Object> get props => [isMapInitialized,isFollowingUser,polylines,markers,showMyRoute];


}


