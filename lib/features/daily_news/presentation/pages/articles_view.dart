import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/presentation/empty_data_widget.dart';
import 'package:news_app/core/presentation/error_widget.dart';
import 'package:news_app/core/presentation/loader_widget.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bottom_sheets/app_bottom_sheets.dart';
import 'package:news_app/features/daily_news/presentation/providers/articles_provider.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:news_app/features/daily_news/presentation/widgets/grid_item.dart';
import 'package:news_app/features/daily_news/presentation/widgets/home_appbar.dart';
import 'package:news_app/features/daily_news/presentation/widgets/list_item.dart';

class ArticlesView extends ConsumerWidget {
  const ArticlesView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewAsGrid = ref.watch(viewAsCardsProvider);
    final selectedSection = ref.watch(selectedSectionProvider);
    final controller = ref.watch(articleNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          child: Column(
            children: [
              HomeAppBarWidget(
                onSearch: (keyWord) => ref
                    .read(articleNotifierProvider.notifier)
                    .searchFilter(keyWord),
                isFetchingData: controller.isLoading,
                onTapFilter: () {
                  FocusScope.of(context).unfocus();
                  AppBottomSheets.chooseSection(context,
                          selectedSection: selectedSection)
                      .then((section) {
                    if (section != null &&
                        ref.read(selectedSectionProvider.notifier).state !=
                            section) {
                      ref.read(selectedSectionProvider.notifier).state =
                          section;
                      ref
                          .read(articleNotifierProvider.notifier)
                          .swichSection(section);
                    }
                  });
                },
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref
                      .read(articleNotifierProvider.notifier)
                      .refreshData(
                          ref.read(selectedSectionProvider.notifier).state),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: controller.when(
                        data: (data) {
                          return Visibility(
                            visible: data.isEmpty,
                            replacement: Padding(
                              padding: EdgeInsets.all(2.w),
                              child: Visibility(
                                visible: viewAsGrid,
                                replacement: listViewItems(data),
                                child: cardsViewItems(data),
                              ),
                            ),
                            child: const EmptyDataWidget(),
                          );
                        },
                        error: (error, stackTrace) => AppErrorWidget(
                            error: error, stackTrace: stackTrace),
                        loading: () => LoaderWidget(size: 70.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView listViewItems(List<ArticleEntity> data) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ListItemCard(model: data[index]);
      },
    );
  }

  GridView cardsViewItems(List<ArticleEntity> data) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 5.h, // spacing between rows
        crossAxisSpacing: 5.w, // spacing between columns
      ),
      itemBuilder: (context, index) {
        return GridItemWidget(model: data[index]);
      },
    );
  }
}
