

import 'dart:convert';

SearchMovies searchMoviesFromJson(String str) => SearchMovies.fromJson(json.decode(str));

String searchMoviesToJson(SearchMovies data) => json.encode(data.toJson());

class SearchMovies {
  SearchMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory SearchMovies.fromJson(Map<String, dynamic> json) => SearchMovies(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"] ?? '',
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: originalLanguageValues.map[json["original_language"]],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"] ?? '',
    releaseDate: json["release_date"] ?? '',
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath ?? '',
    "genre_ids":genreIds!=null? List<dynamic>.from(genreIds!.map((x) => x)):[],
    "id": id,
    "original_language":originalLanguageValues.reverse!=null? originalLanguageValues.reverse![originalLanguage]:"en",
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath ?? '',
    "release_date": releaseDate ?? '',
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum OriginalLanguage { English, Norwegian, Italian, Polish,Indonesian,Spanish,Korean,Japanese,Hindi}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.English,
  "it": OriginalLanguage.Italian,
  "no": OriginalLanguage.Norwegian,
  "pl": OriginalLanguage.Polish,
  "id":OriginalLanguage.Indonesian,
  "es":OriginalLanguage.Spanish,
  "ja":OriginalLanguage.Japanese,
  "ko":OriginalLanguage.Korean,
  "hi":OriginalLanguage.Hindi
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
