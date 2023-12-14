import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/cached_datasorce.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/database_service.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/articles_api_service.dart';
import 'package:news_app/features/daily_news/data/repositories_impl/article_repository_impl.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/check_is_article_in_archive.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_article.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_local_article.dart';
import 'package:news_app/features/daily_news/domain/use_cases/remove_local_article.dart';
import 'package:news_app/features/daily_news/domain/use_cases/remove_setion_articles_from_cache.dart';
import 'package:news_app/features/daily_news/domain/use_cases/save_local_article.dart';
import 'package:news_app/injection_container.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'general_providers.g.dart';

final viewAsCardsProvider = StateProvider.autoDispose<bool>(
    (ref) => sl<ChachedDatasource>().getViewAsCards());

final selectedSectionProvider = StateProvider.autoDispose<String>(
    (ref) => sl<ChachedDatasource>().getSelectedSection());

final isLightModeProvider = StateProvider.autoDispose<bool>(
    (ref) => sl<ChachedDatasource>().getIsLightThemeFromCache());

final isArticleInArchiveProvider =
    StateProvider.autoDispose<bool>((ref) => false);

// ======================For Local Database==========================

@riverpod
DatabaseService databaseService(DatabaseServiceRef ref) =>
    DatabaseService(sl<Store>());

@riverpod
GetLocalArticleUseCase getLocalArticleUseCase(GetLocalArticleUseCaseRef ref) =>
    GetLocalArticleUseCase(ref.watch(articlesRepoProvider));

@riverpod
SaveLocalArticleUseCase saveLocalArticleUseCase(
        SaveLocalArticleUseCaseRef ref) =>
    SaveLocalArticleUseCase(ref.watch(articlesRepoProvider));

@riverpod
RemoveLocalArticleUseCase removeLocalArticleUseCase(
        RemoveLocalArticleUseCaseRef ref) =>
    RemoveLocalArticleUseCase(ref.watch(articlesRepoProvider));
@riverpod
RemoveSetionArticlesFromCacheUseCase removeSetionArticlesFromCacheUseCase(
        RemoveSetionArticlesFromCacheUseCaseRef ref) =>
    RemoveSetionArticlesFromCacheUseCase(ref.watch(articlesRepoProvider));

@riverpod
CheckIsArticleInArchiveUseCase checkInArchiveUseCase(
        CheckInArchiveUseCaseRef ref) =>
    CheckIsArticleInArchiveUseCase(ref.watch(articlesRepoProvider));

// ======================For Remote API==========================
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
      ref.watch(articlesApiServiceProvider),
      ref.watch(databaseServiceProvider),
      sl<ChachedDatasource>(),
      sl<NetworkInfoImp>(),
    );
