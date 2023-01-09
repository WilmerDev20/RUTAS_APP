part of 'mapa_bloc.dart';

 class MapaState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;

  final bool showMyRoute;



  //PolyLines

  final Map<String, Polyline> polylines;


  const MapaState( {Map<String, Polyline>? polylines,this.isMapInitialized= false,  this.isFollowingUser=true,this.showMyRoute=false}) : polylines = polylines ?? const {};


  MapaState copywith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylinesC,
    bool? showMyRoute

  }
  ) => MapaState(
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    polylines: polylinesC ?? this.polylines,
    showMyRoute: showMyRoute?? this.showMyRoute
  );


    @override
  List<Object> get props => [isMapInitialized,isFollowingUser,polylines,showMyRoute];
}


