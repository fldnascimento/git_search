import 'package:flutter/material.dart';

import 'src/injection_container.dart' as di;
import 'src/presenter/style/app_theme.dart';
import 'src/routes.dart';

void main() {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Github Search',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: getRoutes,
    );
  }
}
