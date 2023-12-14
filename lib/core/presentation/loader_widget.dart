import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key, this.size, this.color});
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningLines(
        size: size ?? 20.w,
        color: color ?? Theme.of(context).hintColor,
      ),
    );
  }
}
