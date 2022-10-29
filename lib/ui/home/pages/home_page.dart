import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_rawg_api/repository/game_repository.dart';
import 'package:flutter_bloc_rawg_api/repository/services/game_service.dart';
import 'package:flutter_bloc_rawg_api/ui/home/pages/home_layout.dart';
import 'package:flutter_bloc_rawg_api/ui/home/widgets/all_games_widget/logic/all_games_bloc.dart';

import '../widgets/category_widget/logic/category_bloc.dart';
import '../widgets/games_by_category_widget/logic/games_by_category_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: RepositoryProvider(
        create: (context) => GameRepository(service: GameServices()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AllGamesBloc>(
              create: (context) =>
                  AllGamesBloc(gameRepository: context.read<GameRepository>())
                    ..add(GetGames()),
            ),
            BlocProvider<CategoryBloc>(
              create: (context) => CategoryBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(GetCategories()),
            ),
            BlocProvider<GamesByCategoryBloc>(
              create: (context) => GamesByCategoryBloc(
                gameRepository: context.read<GameRepository>(),
              ),
            ),
          ],
          child: const HomeLayout(),
        ),
      ),
    );
  }
}
