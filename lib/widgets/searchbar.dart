import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/blocs/blocs.dart';
import 'package:rutas_app/delegates/delegates.dart';
import 'package:rutas_app/models/models.dart';
import 'package:animate_do/animate_do.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker 
              ?  SizedBox()
              : _SearchBarBody();
      },
    );
  }
}


class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({super.key});


  void onSearchResults(BuildContext context,SearchResult resultado){
    final searchBloc= BlocProvider.of<SearchBloc>(context);

    if(resultado.manual==true){
      searchBloc.add(OnActivateManualMarkerEvent());

      return;

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async{
            final resultado= await showSearch(context: context, delegate: SearchDestinationDelegate());

            if(resultado==null )return;

           onSearchResults(context,resultado);



          },
          child: FadeInDown(
            duration: Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0,5)
                  )
                ]
              ),
              child: Text('Donde quieres ir',style: TextStyle(color: Colors.black87),),
          
            ),
          ),
        ),
    
      ),
    );




  }
}