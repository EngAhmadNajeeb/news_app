import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';

class LocalArticlesAppbarWigdet extends ConsumerWidget {
  const LocalArticlesAppbarWigdet({
    super.key,
    this.onSearch,
    this.viewAsGrid = false,
    this.isFetchingData = false,
  });
  final bool isFetchingData;
  final bool viewAsGrid;
  final void Function(String)? onSearch;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: onSearch,
              enabled: !isFetchingData,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, size: 16.w),
                contentPadding: EdgeInsets.all(12.r),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(viewAsCardsProvider.notifier).state = false;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Icon(
                Icons.view_list,
                size: 22.w,
                color: viewAsGrid
                    ? Theme.of(context).highlightColor
                    : Theme.of(context).hintColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(viewAsCardsProvider.notifier).state = true;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Icon(
                Icons.grid_view_rounded,
                size: 18.w,
                color: viewAsGrid
                    ? Theme.of(context).hintColor
                    : Theme.of(context).highlightColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
