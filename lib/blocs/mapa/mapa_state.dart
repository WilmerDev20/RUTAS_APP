part of 'mapa_bloc.dart';

 class MapaState extends Equatable {
  

  

  final bool isMapInitialized;
  final bool isFollowingUser;

  const MapaState({ this.isMapInitialized= false,  this.isFollowingUser=false});


  MapaState copywith({
    bool? isMapInitialized,
    bool? isFollowingUser,

  }
  ) => MapaState(
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized
  );


    @override
  List<Object> get props => [isMapInitialized,isFollowingUser];
}


