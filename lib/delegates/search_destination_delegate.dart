


import 'package:flutter/material.dart';
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
    return Text('buildResults');
  }



  @override
  Widget buildSuggestions(BuildContext context) {
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


        )
      ],
    );
  }




}