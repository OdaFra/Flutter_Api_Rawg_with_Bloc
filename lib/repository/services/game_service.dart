import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_bloc_rawg_api/repository/models/result_error.dart';
import '../models/model_barrel.dart';

class GameServices {
  final String baseUrl;
  final Client _httpClient;

  GameServices({
    this.baseUrl = 'https://api.rawg.io/api',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    final queryParameters = <String, String>{
      'key': dotenv.get('GAMES_API_KEY')
    };
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }
    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: queryParameters,
    );
  }

  Future<Game> getGames() async {
    final response = await _httpClient.get(
      getUrl(url: 'games'),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return Game.fromJson(
          json.decode(response.body),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingGames('Error getting games');
    }
  }

  Future<List<Genre>> getGenres() async {
    final response = await _httpClient.get(
      getUrl(url: 'genres'),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<Genre>.from(
          json.decode(response.body)['results'].map(
                (data) => Genre.fromJson(data),
              ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingGames('Error getting games');
    }
  }

  Future<List<Result>> getGamesByCategory(int genreId) async {
    final response = await _httpClient.get(
      getUrl(
        url: 'games',
        extraParameters: {
          'genres': genreId.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<Result>.from(
          jsonDecode(response.body)['results'].map(
            (data) => Result.fromJson(data),
          ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingGames('Error getting games');
    }
  }
}
