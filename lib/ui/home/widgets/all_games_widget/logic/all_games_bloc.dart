import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_rawg_api/repository/game_repository.dart';

import '../../../../../repository/models/game.dart';

part 'all_games_event.dart';
part 'all_games_state.dart';

class AllGamesBloc extends Bloc<AllGamesEvent, AllGamesState> {
  final GameRepository gameRepository;
  AllGamesBloc({required this.gameRepository}) : super(const AllGamesState()) {
    on<GetGames>(getGamesEventToState);
  }

  FutureOr<void> getGamesEventToState(
      GetGames event, Emitter<AllGamesState> emit) async {
    try {
      emit(state.copyWith(status: AllGamesStatus.loading));
      final games = await gameRepository.getGames();
      emit(state.copyWith(status: AllGamesStatus.success, games: games));
    } catch (error) {
      emit(state.copyWith(status: AllGamesStatus.error));
    }
  }
}
