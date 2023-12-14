import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/presentation/empty_data_widget.dart';
import 'package:news_app/features/daily_news/presentation/providers/sections_filter_provider.dart';
import 'package:news_app/features/daily_news/presentation/widgets/section_card.dart';

class ChooseSectionBottomSheet extends ConsumerWidget {
  const ChooseSectionBottomSheet({required this.selectedSection, super.key});
  final String? selectedSection;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(sectionsFilterNotifierProvider);
    // final controle = Get.put(SectionViewModel());

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                ),
              ),
              child: TextFormField(
                onChanged: (keyWord) => ref
                    .read(sectionsFilterNotifierProvider.notifier)
                    .searchFilter(keyWord),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, size: 16.w),
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: list.isEmpty,
                replacement: ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SectionCard(
                      name: list[index],
                      isSelected: selectedSection == list[index],
                    );
                  },
                ),
                child: const EmptyDataWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
