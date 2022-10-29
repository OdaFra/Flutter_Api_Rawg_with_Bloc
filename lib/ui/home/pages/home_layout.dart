import 'package:flutter/material.dart';

import '../../widgets/container_body.dart';
import '../widgets/all_games_widget/all_games_widget.dart';
import '../widgets/category_widget/category_widget.dart';
import '../widgets/games_by_category_widget/games_by_category_widget.dart';
import '../widgets/header_title/header_title.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HeaderTitle(),
          SizedBox(height: 40.0),
          ContainerBody(
            children: [
              CategoriesWidget(),
              GamesByCategoryWidget(),
              AllGamesWidget(title: 'All games'),
            ],
          )
        ],
      ),
    );
  }
}
