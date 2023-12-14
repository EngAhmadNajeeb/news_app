import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/resources/app_images.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key, required this.error, required this.stackTrace});
  final Object error;
  final StackTrace stackTrace;
  @override
  Widget build(BuildContext context) {
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
    String errorMsg = '';
    switch (error.runtimeType) {
      case DioException:
        errorMsg = (error as DioException).message ?? '';
        break;
      case NoInternetExceptiona:
        errorMsg = (error as NoInternetExceptiona).message;
        break;
      default:
        errorMsg = error.toString();
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.noResult,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            Text(
              errorMsg,
              style: const TextStyle(
                // color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Text(
            //   errorMsg,
            //   style: const TextStyle(color: Colors.black, fontSize: 15),
            // ),
          ],
        ),
      ),
    );
  }
}
