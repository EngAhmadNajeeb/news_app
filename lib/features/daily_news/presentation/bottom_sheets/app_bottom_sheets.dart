import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/presentation/bottom_sheets/choose_section_btm_sheet.dart';

class AppBottomSheets {
  static Future<String?> chooseSection(
    BuildContext context, {
    required String? selectedSection,
  }) async {
    final section = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ChooseSectionBottomSheet(
          selectedSection: selectedSection,
        ),
      ),
    );
    return section;
  }
}
