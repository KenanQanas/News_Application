import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/components/components.dart';
import 'package:news/cubit/app_cubit.dart';
import 'package:news/cubit/app_states.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text(
                        'Search',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: Theme.of(context).inputDecorationTheme.border,
                    ),
                    onChanged: (value) {
                      AppCubit.get(context).getSearchData(value);
                    },
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.searchArticles.isNotEmpty,
                  builder: (context) => ListView.separated(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        BuildArticle(cubit.searchArticles[index], context),
                    separatorBuilder: (context, index) => MyDivider(),
                    itemCount: cubit.searchArticles.length,
                  ),
                  fallback: (context) => const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*

return ConditionalBuilder(
condition: cubit.searchArticles.isNotEmpty,
builder: (context) =>
ListView.separated(
//cubit.scienceArticles.length,
itemCount: cubit.searchArticles.length,
itemBuilder: (context , index) => BuildArticle(cubit.searchArticles[index],context),
separatorBuilder : (context , index)  => MyDivider()
),
fallback: (context) =>
const Center(child: CircularProgressIndicator(),)
);*/
