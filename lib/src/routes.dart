import 'package:git_search/src/presenter/pages/list_users_page.dart';
import 'package:git_search/src/presenter/pages/search_page.dart';
import 'package:git_search/src/presenter/pages/splash_page.dart';
import 'package:git_search/src/presenter/pages/user_info_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/list-users/:query',
      builder: (context, state) =>
          ListUsersPage(query: state.params['query'] ?? ''),
    ),
    // GoRoute(
    //   path: '/list-repos/:query',
    //   builder: (context, state) =>
    //       ListUsersPage(query: state.params['query'] ?? ''),
    // ),
    GoRoute(
      path: '/user/:login',
      builder: (context, state) => UserInfoPage(
        login: state.params['login'] ?? '',
      ),
    ),
  ],
);
