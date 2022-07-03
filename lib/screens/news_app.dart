import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/app_cubit.dart';
import 'package:news/cubit/app_states.dart';

import '../components/components.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.newsArticles.isNotEmpty,
            builder: (context) =>
                ListView.separated(
                  itemCount: cubit.newsArticles.length,
                  itemBuilder: (context , index) => BuildArticle(cubit.newsArticles[index] , context),
                  separatorBuilder : (context , index)  => MyDivider()
                ),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}
