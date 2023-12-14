import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/articles_api_service.dart';
import 'package:news_app/features/daily_news/data/repositories_impl/article_repository_impl.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_article.dart';
import 'package:news_app/injection_container.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'general_providers.g.dart';

final viewAsCardsProvider = StateProvider.autoDispose<bool>(
    (ref) => false);

final selectedSectionProvider = StateProvider.autoDispose<String>(
    (ref) => kHome);

final isLightModeProvider = StateProvider.autoDispose<bool>(
    (ref) => true);

final isArticleInArchiveProvider =
    StateProvider.autoDispose<bool>((ref) => false);

@riverpod
Dio dio(DioRef ref) => Dio();

@riverpod
ArticleApiService articlesApiService(ArticlesApiServiceRef ref) =>
    ArticleApiService(ref.watch(dioProvider));

@riverpod
GetArticleUseCase getArticleUseCase(GetArticleUseCaseRef ref) =>
    GetArticleUseCase(ref.watch(articlesRepoProvider));

// ==================Repo for Local and API==============================
@riverpod
ArticleRepository articlesRepo(ArticlesRepoRef ref) => ArticleRepositoryImpl(
      sl<NetworkInfoImp>(),
      ref.watch(articlesApiServiceProvider),
    );
