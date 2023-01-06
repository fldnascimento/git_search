import 'package:flutter/material.dart';
import 'package:git_search/src/presenter/pages/search_page.dart';

import 'src/injection_container.dart' as di;
import 'src/presenter/pages/splash_page.dart';

void main() {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SearchPage(),
    );
  }
}
