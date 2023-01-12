part of 'search_bloc.dart';

 class SearchState extends Equatable {
  
  final bool displayManualMarker;
  
  final List<Feature?> places;

  final List<Feature?> history;


  const SearchState( { this.places = const [],this.displayManualMarker=false,this.history = const []});
  




SearchState copyWith({
  bool? displayManualMarker,
  List<Feature?>? placesC,
  List<Feature?>? historyC

})=> SearchState(
  displayManualMarker: displayManualMarker ?? this.displayManualMarker,
  places: placesC ?? places,
  history: historyC ?? history
  
);


  @override
  List<Object> get props => [displayManualMarker,places,history];
}


