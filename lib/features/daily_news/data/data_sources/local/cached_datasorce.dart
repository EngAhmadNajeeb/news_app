import 'dart:async';
import 'dart:convert';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChachedDatasource{
  final SharedPreferences sharedPreferences;
  ChachedDatasource({required this.sharedPreferences});

  FutureOr cachSectionArticles(
      String section, List<ArticleModel> articles) async {
    final jsonData = json.encode(
      List<Map<String, dynamic>>.from(
        articles.map((e) => e.toJson()).toList(),
      ),
    );
    await sharedPreferences.setString(section, jsonData);
  }

  List<ArticleModel> getSectionArticles(String section) {
    final stringIson = sharedPreferences.getString(section);
    if (stringIson != null) {
      return (json.decode(stringIson) as List)
          .map((e) => ArticleModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  Future<bool> removeSetionArticlesFromCache(String section) async {
    return await sharedPreferences.remove(section);
  }

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
