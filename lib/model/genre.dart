
import 'dart:convert';

Generes generesFromJson(String str) => Generes.fromJson(json.decode(str));

String generesToJson(Generes data) => json.encode(data.toJson());

class Generes {
  Generes({
    this.genres,
  });

  List<Genre>? genres;

  factory Generes.fromJson(Map<String, dynamic> json) => Generes(
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres":genres!=null? List<dynamic>.from(genres!.map((x) => x.toJson())):[],
  };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
