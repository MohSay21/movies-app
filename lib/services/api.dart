import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/details.dart';
import 'package:movies_app/models/show.dart';

class API {

  final String _url = 'https://imdb-api.com/API';
  final String _key = 'k_r583usqr';

  returnShows(String response, String? object) {
    final json = jsonDecode(response);
    if (object == null){
      return Details.fromJSON(json);
    }
    else {
      final shows = json[object] as List;
      return List<Show>.from(shows.map((x) => Show.fromJSON(x)));
    }
  }

  Future<List<Show>> searchMovies(String keyWord) async {
    final url = '$_url/SearchMovie/$_key/$keyWord';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result =  returnShows(response.body, "results");
        return result;
    } else {
        throw Exception('Network error...');
      }
  }

  Future<List<Show>> searchSeries(String keyWord) async {
    final url = '$_url/SearchSeries/$_key/$keyWord';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result =  returnShows(response.body, "results");
        return result;
    } else {
        throw Exception('Network error...');
      }
  }

  Future<List<Show>> mylistShows(List<String> ids) async {
    final url = '$_url/Title/$_key';
    List<Show> shows = [];
    for (var i = 0; i < ids.length; i++) {
      final response = await http.get(Uri.parse('$url/${ids[i]}'));
      if (response.statusCode == 200) {
        final show = jsonDecode(response.body);
        shows.add(Show.fromJSON(show));
      } else {
        throw Exception('Network Error');
      }
    }
    return shows;
  }

  Future<Details> getDetails(String id) async {
    final url = '$_url/Title/$_key/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = Details.fromJSON(json);
      return result;
    } else {
      throw Exception('Network error...');
    }
  }

  Future<List<Show>> popularMovies() async {
    final url = '$_url/MostPopularMovies/$_key';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result =  returnShows(response.body, "items");
        return result;
    } else {
        throw Exception('Network error...');
      }
  }

  Future<List<Show>> popularSeries() async {
    final url = '$_url/MostPopularTVs/$_key';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result =  returnShows(response.body, "items");
        return result;
    } else {
        throw Exception('Network error...');
      }
  }

  Future<List<Show>> search(String params) async {
    final url = '$_url/AdvancedSearch/$_key?$params';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result =  returnShows(response.body, "results");
      return result;
    } else {
      throw Exception('Network error...');
    }
  }

}