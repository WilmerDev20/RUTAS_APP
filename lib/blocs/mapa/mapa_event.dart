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