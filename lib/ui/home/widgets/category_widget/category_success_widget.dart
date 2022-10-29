import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_rawg_api/repository/models/model_barrel.dart';
import 'package:flutter_bloc_rawg_api/ui/home/widgets/category_widget/category_item.dart';
import 'package:flutter_bloc_rawg_api/ui/home/widgets/category_widget/logic/category_bloc.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .15,
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemBuilder: (context, index) {
              return CategoryItem(
                  key: ValueKey('${state.categories[index].name}$index'),
                  category: state.categories[index],
                  callback: (Genre categorySelected) {
                    context
                        .read<CategoryBloc>()
                        .add(SelectCategory(idSelected: categorySelected.id));
                  });
            },
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(
              width: 16.0,
            ),
            itemCount: state.categories.length,
          ),
        );
      },
    );
  }
}
