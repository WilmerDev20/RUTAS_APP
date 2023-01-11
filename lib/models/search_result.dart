

class SearchResult {

  final bool cancel;

  final bool? manual;

  //Nombre del destino, descripcion, latlg

  SearchResult({
    required this.cancel,
    this.manual= false,
  });

 @override
String toString() { 

  return 'cancel : $cancel - manual: $manual';
}

}