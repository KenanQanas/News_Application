import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cache/cache_helper.dart';
import 'package:news/components/components.dart';
import 'package:news/dio_helpers/dio_helpers.dart';
import 'package:news/screens/search_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/app_cubit.dart';
import 'cubit/app_states.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context: context, screen: SearchApp());
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.brightness_6,
                ),
                onPressed: () {
                  cubit.changeMode();
                },
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.index,
            onTap: (newIndex) {
              cubit.changeBottomNavIndex(newIndex);
            },
          ),
          body: cubit.screens[cubit.index],
        );
      },
    );
  }
}
