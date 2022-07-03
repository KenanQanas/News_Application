import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_states.dart';

class ScienseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.scienceArticles.isNotEmpty,
            builder: (context) =>
                ListView.separated(
                  //cubit.scienceArticles.length,
                    itemCount: cubit.scienceArticles.length,
                    itemBuilder: (context , index) => BuildArticle(cubit.scienceArticles[index],context),
                    separatorBuilder : (context , index)  => MyDivider()
                ),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}
