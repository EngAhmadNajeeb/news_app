import 'dart:async';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/cached_datasorce.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/articles_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NetworkInfo networkInfo;
  final ArticleApiService _newsApiService;
  final ChachedDatasource _chachedDatasource;
  ArticleRepositoryImpl(
      this.networkInfo, this._newsApiService, this._chachedDatasource);
  @override
  Future<List<ArticleModel>> getArticles(String section) async {
    var localArticles = _chachedDatasource.getSectionArticles(section);

    if (localArticles.isNotEmpty) {
      return localArticles;
    } else {
      if (await networkInfo.isConnected) {
        final response = await _newsApiService.getNewsArticles(
            Uri.encodeComponent(section), kApiKey);
        _chachedDatasource.cachSectionArticles(section, response.results);
        return response.results;
      } else {
        throw NoInternetExceptiona();
      }
    }
  }
}
