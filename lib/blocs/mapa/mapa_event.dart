part of 'mapa_bloc.dart';

abstract class MapaEvent extends Equatable {
  const MapaEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialzed extends MapaEvent{
  final GoogleMapController controller;

  const OnMapInitialzed(this.controller);

}


class OnStartFollowingUserEvent extends MapaEvent{}


class OnStopFollowingUserEvent extends MapaEvent{}

class UpdateUserPolylineEvent extends MapaEvent{
  final List<LatLng> userHistory;

  const UpdateUserPolylineEvent(this.userHistory);
}


class OnToggleUserRouteEvent extends MapaEvent{}