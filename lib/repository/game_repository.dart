import 'package:flutter_bloc_rawg_api/repository/models/model_barrel.dart';
import 'package:flutter_bloc_rawg_api/repository/services/game_service.dart';

class GameRepository {
  final GameServices service;

  const GameRepository({
    required this.service,
  });

  Future<Game> getGames() async => service.getGames();
  Future<List<Genre>> getGenres() async => service.getGenres();
  Future<List<Result>> getGamesByCategory(int genreId) async =>
      service.getGamesByCategory(genreId);
}
