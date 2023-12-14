import 'dart:async';
import 'package:news_app/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChachedDatasource {
  final SharedPreferences sharedPreferences;
  ChachedDatasource({required this.sharedPreferences});

  bool getIsLightThemeFromCache() {
    return sharedPreferences.getBool('theme') ?? true;
  }

  Future<bool> setIsLightThemeToCache(bool isLight) {
    return sharedPreferences.setBool('theme', isLight);
  }

  bool getViewAsCards() {
    return sharedPreferences.getBool('ViewAsCards') ?? false;
  }

  Future<bool> setViewAsCards(bool viewAsCards) {
    return sharedPreferences.setBool('ViewAsCards', viewAsCards);
  }

  String getSelectedSection() {
    return sharedPreferences.getString('SelectedSection') ?? kHome;
  }

  Future<bool> setSelectedSection(String section) {
    return sharedPreferences.setString('SelectedSection', section);
  }
}
