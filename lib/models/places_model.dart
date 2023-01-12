// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PlacesResponse {
    PlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    final String? type;
    final List<String?>? query;
    final List<Feature?> features;
    final String? attribution;

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: json["query"] == null ? [] : List<String?>.from(json["query"]!.map((x) => x)),
        features: json["features"] == null ? [] : List<Feature?>.from(json["features"]!.map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "query": query == null ? [] : List<dynamic>.from(query!.map((x) => x)),
        "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x!.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.properties,
        required this.textEs,
        required this.placeNameEs,
        required this.text,
        required this.language,
        required this.placeName,
        required this.bbox,
        required this.center,
        required this.geometry,
        required this.context,
    });

    final String? id;
    final String? type;
    final List<String?>? placeType;
    final Properties? properties;
    final String? textEs;
    final String? placeNameEs;
    final String text;
    final String? language;
    final String? placeName;
    final List<double?>? bbox;
    final List<double?>? center;
    final Geometry? geometry;
    final List<Context?>? context;

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: json["place_type"] == null ? [] : List<String?>.from(json["place_type"]!.map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        // languageEs: json["language_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null ? [] : json["bbox"] == null ? [] : List<double?>.from(json["bbox"]!.map((x) => x.toDouble())),
        center: json["center"] == null ? [] : List<double?>.from(json["center"]!.map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: json["context"] == null ? [] : List<Context?>.from(json["context"]!.map((x) => Context.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": placeType == null ? [] : List<dynamic>.from(placeType!.map((x) => x)),
        "properties": properties!.toMap(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "language": language,
        "place_name": placeName,
        "bbox": bbox == null ? [] : bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
        "center": center == null ? [] : List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry!.toMap(),
        "context": context == null ? [] : List<dynamic>.from(context!.map((x) => x!.toMap())),
    };


    @override
  String toString() {
   
    return 'Feature : $text';
  }
}

class Context {
    Context({
        required this.id,
        required this.shortCode,
        required this.wikidata,
        required this.textEs,
        required this.languageEs,
        required this.text,
        required this.language,
    });

    final String? id;
    final String? shortCode;
    final String? wikidata;
    final String? textEs;
    final String? languageEs;
    final String? text;
    final String? language;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        shortCode: json["short_code"],
        wikidata: json["wikidata"],
        textEs: json["text_es"],
        languageEs: json["language_es"],
        text: json["text"],
        language: json["language"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "short_code": shortCode,
        "wikidata": wikidata,
        "text_es": textEs,
        "language_es": languageEs,
        "text": text,
        "language": language,
    };
}


class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double?>? coordinates;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<double?>.from(json["coordinates"]!.map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

class Properties {
    Properties({
        required this.wikidata,
        required this.accuracy,
    });

    final String? wikidata;
    final String? accuracy;

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        accuracy: json["accuracy"],
    );

    Map<String, dynamic> toMap() => {
        "wikidata": wikidata,
        "accuracy": accuracy,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
