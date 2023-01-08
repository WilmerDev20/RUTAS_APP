part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class NewLocationEvent extends LocationEvent{
  final LatLng newlocation;

  const NewLocationEvent(this.newlocation);


}


class StartFollowingUserEvent extends LocationEvent{}

class StopFollowingUserEvent extends LocationEvent{}
