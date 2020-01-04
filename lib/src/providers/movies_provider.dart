import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:moviesapp/src/model/movies_model.dart';

class MoviesProvider {
  String _apiKey = '333a6dcf59b9c3660ec3f16864e41da9';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  Uri _getUrl(String path) {
    return Uri.https(_url, path, {'api_key': _apiKey, 'language': _language});
  }

  Future<List<Movie>> _responses(Uri url) async {
    final res = await http.get(url);
    final data = json.decode(res.body);
    final movies = new Movies.fromJsonMap(data['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    var uri = _getUrl('3/movie/now_playing');
    return await _responses(uri);
  }

  Future<List<Movie>> getPopular() async {
    var uri = _getUrl('3/movie/popular');
    return await _responses(uri);
  }
}
