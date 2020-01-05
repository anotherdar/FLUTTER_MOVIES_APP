import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:moviesapp/src/model/movies_model.dart';

class MoviesProvider {
  String _apiKey = '333a6dcf59b9c3660ec3f16864e41da9';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';
  int _popularsPage = 0;
  bool _loading = false;
  Uri _getUrl(String path, [int page]) {
    if (page != null) {
      return Uri.https(_url, path,
          {'api_key': _apiKey, 'language': _language, 'page': page.toString()});
    } else {
      return Uri.https(_url, path, {
        'api_key': _apiKey,
        'language': _language,
      });
    }
  }

  List<Movie> _populars = new List();

  final _popularsStream = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularsStream.sink.add;

  Stream<List<Movie>> get popularStream => _popularsStream.stream;

  void disposeStreams() {
    _popularsStream?.close();
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
    if (_loading) return [];
    _loading = true;
    _popularsPage++;
    var uri = _getUrl('3/movie/popular', _popularsPage);
    final res = await _responses(uri);

    _populars.addAll(res);
    popularSink(_populars);
    _loading = false;
    return res;
  }
}
