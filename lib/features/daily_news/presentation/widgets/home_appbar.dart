import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';

class HomeAppBarWidget extends ConsumerWidget {
  const HomeAppBarWidget({
    super.key,
    this.onTapFilter,
    this.onSearch,
    this.isFetchingData = false,
  });
  final bool isFetchingData;
  final void Function(String)? onSearch;
  final void Function()? onTapFilter;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewAsGrid = ref.watch(viewAsCardsProvider);
    final isLightMode = ref.watch(isLightModeProvider);
    return Row(
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
          onTap: isFetchingData ? null : onTapFilter,
          child: Icon(
            Icons.filter_alt,
            size: 25.w,
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            FocusScope.of(context).unfocus();
            switch (value) {
              case 'SavedArticles':
                break;
              case 'ViewAs':
                ref.read(viewAsCardsProvider.notifier).state = !viewAsGrid;
                break;
              case 'mode':
                ref.read(isLightModeProvider.notifier).state = !isLightMode;
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'SavedArticles',
                child: menuItem('Saved articles', Icons.bookmark),
              ),
              PopupMenuItem<String>(
                value: 'ViewAs',
                child: menuItem(
                  viewAsGrid ? 'View As List' : 'View As Grid',
                  viewAsGrid ? Icons.view_list : Icons.grid_view_rounded,
                ),
              ),
              PopupMenuItem<String>(
                value: 'mode',
                child: menuItem(
                  isLightMode ? 'Dark Mode' : 'Light Mode',
                  isLightMode ? Icons.dark_mode : Icons.light_mode,
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget menuItem(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Row(
        children: [
          Icon(icon, size: 20.w),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
