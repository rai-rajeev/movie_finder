import 'package:find_movies/model/genre.dart';
import 'package:find_movies/model/now_playing.dart';
import 'package:find_movies/model/searchmovies.dart';
import 'package:find_movies/model/trendingMovies.dart';
import 'package:http/http.dart' as http;

import '../model/top_rated_movies.dart';

class RemoteServices {
  var client = http.Client();
  Future<TrendingMovies?> getTrending() async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=a2ad222507cfbfcfc69e2ffbdfaed7e0');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return trendingMoviesFromJson(json);
      }
      throw Exception('Some unexpected error occured!');
    } catch (e) {
      rethrow;
    }
  }

  Future<TopRatedMovies?> getToprated() async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=a2ad222507cfbfcfc69e2ffbdfaed7e0');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return topRatedMoviesFromJson(json);
      }
      throw Exception('Some unexpected error occured!');
    } catch (e) {
      rethrow;
    }
  }

  Future<NowPlayingMovies?> getNowPlaying() async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=a2ad222507cfbfcfc69e2ffbdfaed7e0');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return nowPlayingMoviesFromJson(json);
      }
      throw Exception('Some unexpected error occured!');
    } catch (e) {
      rethrow;
    }
  }

  Future<Generes?> getGenre() async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=a2ad222507cfbfcfc69e2ffbdfaed7e0');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return generesFromJson(json);
      }
      throw Exception('Some unexpected error occured!');
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchMovies?> getSearchMovie(String query) async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=a2ad222507cfbfcfc69e2ffbdfaed7e0&query=$query');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return searchMoviesFromJson(json);
      }
      throw Exception('Some unexpected error occured!');
    } catch (e) {
      rethrow;
    }
  }
}
