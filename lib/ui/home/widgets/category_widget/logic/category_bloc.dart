import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_rawg_api/repository/game_repository.dart';

import '../../../../../repository/models/genre.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GameRepository gameRepository;
  CategoryBloc({required this.gameRepository}) : super(const CategoryState()) {
    on<GetCategories>(getCategoriesEventToState);
    on<SelectCategory>(selectCategoryEventToState);
  }

  void getCategoriesEventToState(
      GetCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final genres = await gameRepository.getGenres();
      emit(state.copyWith(status: CategoryStatus.success, categories: genres));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void selectCategoryEventToState(
      SelectCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(
      status: CategoryStatus.selected,
      idSelected: event.idSelected,
    ));
  }
}
