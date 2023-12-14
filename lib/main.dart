import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/theme/app_thems.dart';
import 'package:news_app/features/daily_news/presentation/pages/articles_view.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:news_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode = ref.watch(isLightModeProvider);
    return ScreenUtilInit(
      designSize: const Size(393, 851), // my device
      // minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: isLightMode ? lightTheme() : darkTheme(),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: isLightMode
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            child: const ArticlesView(),
          ),
        );
      },
    );
  }
}
