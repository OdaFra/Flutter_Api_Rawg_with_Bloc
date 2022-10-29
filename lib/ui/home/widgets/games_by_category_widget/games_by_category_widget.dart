import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/error_widget.dart';
import 'games_by_category_success_widget.dart';
import 'logic/games_by_category_bloc.dart';

class GamesByCategoryWidget extends StatelessWidget {
  const GamesByCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesByCategoryBloc, GamesByCategoryState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? GameByCategorySuccessWidget(
                categoryName: state.categoryName,
                games: state.games,
              )
            : state.status.isloading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : state.status.isError
                    ? const ErrorGameWidget()
                    : const SizedBox();
      },
    );
  }
}
