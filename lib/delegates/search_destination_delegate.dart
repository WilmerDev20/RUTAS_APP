import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult>{

  SearchDestinationDelegate():super(
    searchFieldLabel: 'Buscar',

  );


  @override
  List<Widget>? buildActions(BuildContext context) {

    return[
      IconButton(
        onPressed: (){
          query='';
        }, 
        icon: Icon(Icons.clear))
    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton
    (onPressed: (){
      final result= SearchResult(cancel: true);
      close(context, result);
    }, 
    icon: Icon(Icons.arrow_back));
  }



  @override
  Widget buildResults(BuildContext context) {

    final searchBloc= BlocProvider.of<SearchBloc>(context);
    
    final proximity=BlocProvider.of<LocationBloc>(context).state.lastKnowLocation;

    searchBloc.getPlacesByQuery(proximity!, query);
    

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;

        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            final place= places[index];
            return ListTile(

              title: Text(place!.text),
              subtitle: Text(place.placeName!),
              leading: Icon(Icons.place_outlined,color: Colors.black,),
              onTap: (){
                 final result= SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center![1]!,place.center![0]!),
                  name: place.text,
                  description: place.placeName
                  );

                searchBloc.add(AddToHistoryEvent(place));

                  close(context, result);
              },


            );
          },
        );
        

      },
    );



  }



  @override
  Widget buildSuggestions(BuildContext context) {
    final history= BlocProvider.of<SearchBloc>(context).state.history;
    return ListView(
      children:  [
        ListTile(
          leading: Icon(Icons.location_on_outlined,color: Colors.black,),
          title:  Text('Colocar la ubicacio manualmente',style: TextStyle(color: Colors.black),),
          onTap: () {
            //Regresar algo 
            final result= SearchResult(cancel: false,manual: true);
            close(context, result);
          },
      
        ),

        ...history.map((place) => ListTile(
          title: Text(place!.text),
          subtitle: Text(place.placeName!),
          leading: Icon(Icons.history, color: Colors.black,),
          onTap: (){
            final result= SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center![1]!,place.center![0]!),
                  name: place.text,
                  description: place.placeName
                  );


                  close(context, result);
          },
        ))
      ],
    );
  }




}