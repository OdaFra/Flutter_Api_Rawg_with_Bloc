// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_rawg_api/ui/home/widgets/all_games_widget/all_games_success_widget.dart';
import 'package:flutter_bloc_rawg_api/ui/widgets/error_widget.dart';

import 'logic/all_games_bloc.dart';

class AllGamesWidget extends StatelessWidget {
  const AllGamesWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllGamesBloc, AllGamesState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? AllGamesSuccessWidget(games: state.games.results, title: title)
            : state.status.isLoading
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
