import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_images.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.noResult,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          Text(
            'No Result',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
