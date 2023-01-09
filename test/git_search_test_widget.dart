import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:git_search/src/injection_container.dart';
import 'package:git_search/src/presenter/style/app_theme.dart';
import 'package:git_search/src/routes.dart';

class GitSerachTestWidget extends StatelessWidget {
  final String route;
  final Dio? dio;

  const GitSerachTestWidget({
    super.key,
    required this.route,
    this.dio,
  });

  void setupTest() {
    if (dio != null) {
      getIt.unregister(instance: getIt<Dio>());
      getIt.registerLazySingleton<Dio>(() => dio!);
    }
  }

  @override
  Widget build(BuildContext context) {
    setupTest();

    return MaterialApp.router(
      title: 'Github Search',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: routes(initialLocation: route),
    );
  }
}
