import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/presentation/error_widget.dart';
import 'package:news_app/core/presentation/loader_widget.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:news_app/features/daily_news/presentation/providers/locla_articles_provider.dart';
import 'package:news_app/features/daily_news/presentation/widgets/grid_item.dart';
import 'package:news_app/features/daily_news/presentation/widgets/list_item.dart';
import 'package:news_app/features/daily_news/presentation/widgets/local_articles_appbar.dart';

class LocalStoriesView extends ConsumerWidget {
  const LocalStoriesView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewAsGrid = ref.watch(viewAsCardsProvider);
    final controller = ref.watch(localArticlesNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          child: Column(
            children: [
              LocalArticlesAppbarWigdet(
                viewAsGrid: viewAsGrid,
                onSearch: (keyWord) => ref
                    .read(localArticlesNotifierProvider.notifier)
                    .searchFilter(keyWord),
                isFetchingData: controller.isLoading,
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: controller.when(
                  data: (data) {
                    return Visibility(
                      visible: data.isEmpty,
                      replacement: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Visibility(
                          visible: viewAsGrid,
                          replacement: listViewItems(ref, data),
                          child: cardsViewItems(ref, data),
                        ),
                      ),
                      child: const Center(child: Text('No Item')),
                    );
                  },
                  error: (error, stackTrace) =>
                      AppErrorWidget(error: error, stackTrace: stackTrace),
                  loading: () => LoaderWidget(size: 70.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView listViewItems(WidgetRef ref, List<ArticleEntity> data) {
    return ListView.builder(
      itemCount: data.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ListItemCard(
          model: data[index],
          onDelete: () {
            ref
                .read(localArticlesNotifierProvider.notifier)
                .removArticle(data[index]);
          },
        );
      },
    );
  }

  GridView cardsViewItems(WidgetRef ref, List<ArticleEntity> data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 5.h, // spacing between rows
        crossAxisSpacing: 5.w, // spacing between columns
      ),
      itemBuilder: (context, index) {
        return GridItemWidget(
          model: data[index],
          onDelete: () {
            ref
                .read(localArticlesNotifierProvider.notifier)
                .removArticle(data[index]);
          },
        );
      },
    );
  }
}
