import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/app_cubit.dart';
import 'package:news/cubit/app_states.dart';
import 'package:news/home_page.dart';
import 'package:news/screens/news_app.dart';

class MyApp extends StatelessWidget {

  final darkModeFromSharedPreferences;
  MyApp(this.darkModeFromSharedPreferences);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getNewsData()
        ..getScienceData()
        ..getSportsData()
      ..changeMode(darkModeFromSharedPreferences: darkModeFromSharedPreferences),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppChangeModeState) {
            print("mode changed");
          }
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 25.0,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                  size: 30.0,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
              ),
              primaryTextTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 25.0,
                ),
                backgroundColor: Colors.black,
                elevation: 0.0,
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                  size: 30.0,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              scaffoldBackgroundColor: Colors.black,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.black,
              ),
              primaryTextTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).darkMode? ThemeMode.dark : ThemeMode.light,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
