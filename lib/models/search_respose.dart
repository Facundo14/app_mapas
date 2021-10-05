// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.type = '',
    query,
    features,
    this.attribution = '',
  })  : query = query ?? [],
        features = features ?? [];

  String type;
  List<String> query;
  List<Feature> features;
  String attribution;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        type: json["type"] ?? '',
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    this.id = '',
    this.type = '',
    placeType,
    this.relevance = 0.0,
    properties,
    this.textEs = '',
    languageEs,
    this.placeNameEs = '',
    this.text = '',
    language,
    this.placeName = '',
    bbox,
    center,
    geometry,
    context,
    this.matchingText = '',
    this.matchingPlaceName = '',
  })  : placeType = placeType ?? [],
        properties = properties ?? Properties(),
        languageEs = languageEs ?? Language.ES,
        language = language ?? Language.ES,
        bbox = bbox ?? [],
        center = center ?? [],
        geometry = geometry ?? Geometry(),
        context = context ?? [];

  String id;
  String type;
  List<String> placeType;
  double relevance;
  Properties properties;
  String textEs;
  Language languageEs;
  String placeNameEs;
  String text;
  Language language;
  String placeName;
  List<double> bbox;
  List<double> center;
  Geometry geometry;
  List<Context> context;
  String matchingText;
  String matchingPlaceName;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"].toDouble() ?? 0.0,
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"] ?? '',
        languageEs: json["language_es"] == null ? null : languageValues.map![json["language_es"]],
        placeNameEs: json["place_name_es"] ?? '',
        text: json["text"] ?? '',
        language: json["language"] == null ? null : languageValues.map![json["language"]],
        placeName: json["place_name"] ?? '',
        bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        matchingText: json["matching_text"] ?? '',
        matchingPlaceName: json["matching_place_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": language == null ? null : languageValues.reverse[language],
        "place_name": placeName,
        "bbox": bbox == null ? null : List<dynamic>.from(bbox.map((x) => x)),
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
        "matching_text": matchingText == null ? null : matchingText,
        "matching_place_name": matchingPlaceName == null ? null : matchingPlaceName,
      };
}

class Context {
  Context({
    this.id = '',
    this.wikidata = '',
    this.shortCode = '',
    this.textEs = '',
    languageEs,
    this.text = '',
    language,
  })  : languageEs = languageEs ?? Language.ES,
        language = language ?? Language.ES;

  String id;
  String wikidata;
  String shortCode;
  String textEs;
  Language languageEs;
  String text;
  Language language;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"] ?? '',
        wikidata: json["wikidata"] ?? '',
        shortCode: json["short_code"] ?? '',
        textEs: json["text_es"] ?? '',
        languageEs: languageValues.map![json["language_es"]],
        text: json["text"] = '',
        language: languageValues.map![json["language"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wikidata": wikidata,
        "short_code": shortCode,
        "text_es": textEs,
        "language_es": languageValues.reverse[languageEs],
        "text": text,
        "language": languageValues.reverse[language],
      };
}

enum Language { ES }

final languageValues = EnumValues({"es": Language.ES});

class Geometry {
  Geometry({
    this.type = '',
    coordinates,
  }) : coordinates = coordinates ?? [];

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] = '',
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.wikidata = '',
    this.landmark = false,
    this.address = '',
    this.foursquare = '',
    this.category = '',
    this.maki = '',
  });

  String wikidata;
  bool landmark;
  String address;
  String foursquare;
  String category;
  String maki;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"] ?? '',
        landmark: json["landmark"] ?? false,
        address: json["address"] ?? '',
        foursquare: json["foursquare"] ?? '',
        category: json["category"] ?? '',
        maki: json["maki"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata,
        "landmark": landmark,
        "address": address,
        "foursquare": foursquare,
        "category": category,
        "maki": maki,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
