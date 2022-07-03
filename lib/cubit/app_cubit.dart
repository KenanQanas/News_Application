import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cache/cache_helper.dart';
import 'package:news/screens/news_app.dart';
import 'package:news/screens/sciense_app.dart';
import 'package:news/screens/sports_app.dart';

import '../dio_helpers/dio_helpers.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  int index = 0;

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'News',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [NewsApp(), SportsApp(), ScienseApp()];

  void changeBottomNavIndex(int newIndex) {
    index = newIndex;
//    if (newIndex == 1) {
//      getSportsData();
//    } else if (newIndex == 2) {
//      getScienceData();
//    }
    emit(ChangeBottomNavBarState());
  }

  bool loadingData = false;

  List<dynamic> newsArticles = [];

  void getNewsData() async {
    Map<String, dynamic> query = {
      'country': 'us',
      'category': 'business',
      'apiKey': 'e671c77162dd49729682de314eeb3990'
    };
    await DioHelpers.getData(url: 'v2/top-headlines', query: query)
        .then((value) {
      print(value.data);
      newsArticles = value.data['articles'];
      emit(NewsStopLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsErrorState());
    });
  }

  List<dynamic> sportsArticles = [];

  void getSportsData() async {
    Map<String, dynamic> query = {
      'country': 'us',
      'category': 'sports',
      'apiKey': 'e671c77162dd49729682de314eeb3990'
    };
    await DioHelpers.getData(url: 'v2/top-headlines', query: query)
        .then((value) {
      print(value.data);
      sportsArticles = value.data['articles'];
      emit(SportsStopLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(SportsErrorState());
    });
  }

  List<dynamic> scienceArticles = [];

  void getScienceData() async {
    Map<String, dynamic> query = {
      'country': 'us',
      'category': 'science',
      'apiKey': 'e671c77162dd49729682de314eeb3990'
    };
    await DioHelpers.getData(url: 'v2/top-headlines', query: query)
        .then((value) {
      print(value.data);
      scienceArticles = value.data['articles'];
      emit(ScienceStopLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(ScienceErrorState());
    });
  }

  List<dynamic> searchArticles = [];

  void getSearchData(String val) async {
    searchArticles = [];
    emit(SearchStartLoadingState());
    Map<String, dynamic> query = {
      'q': '$val',
      'apiKey': 'e671c77162dd49729682de314eeb3990'
    };
    await DioHelpers.getData(url: 'v2/everything', query: query)
        .then((value) {
      print(value.data['articles'][0]);
      searchArticles = value.data['articles'];
      emit(SearchStopLoadingState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }


  bool darkMode = true;

  void changeMode({darkModeFromSharedPreferences}) {
    if (darkModeFromSharedPreferences == null) {
      darkMode = !darkMode;
      CacheHelper.putData(key: 'isDark', value: darkMode).then((value) {
        print('isDark ? $darkMode');
        emit(AppChangeModeState());
      });
    }
    else {
      darkMode = darkModeFromSharedPreferences;
      CacheHelper.putData(key: 'isDark', value: darkMode).then((value) {
        print('isDark ? $darkMode');
        emit(AppChangeModeState());
      });
    }
  }


}
