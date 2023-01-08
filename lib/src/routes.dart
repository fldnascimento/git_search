import 'package:go_router/go_router.dart';

import 'presenter/pages/list_repos_page.dart';
import 'presenter/pages/list_repos_user_page.dart';
import 'presenter/pages/list_users_page.dart';
import 'presenter/pages/search_page.dart';
import 'presenter/pages/splash_page.dart';
import 'presenter/pages/user_info_page.dart';

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
    GoRoute(
      path: '/list-repos-user/:login/:starred',
      builder: (context, state) => ListReposUserPage(
        login: state.params['login'] ?? '',
        starred: state.params['starred'] == 'true',
      ),
    ),
    GoRoute(
      path: '/list-repos/:query',
      builder: (context, state) => ListReposPage(
        query: state.params['query'] ?? '',
      ),
    ),
    GoRoute(
      path: '/user/:login',
      builder: (context, state) => UserInfoPage(
        login: state.params['login'] ?? '',
      ),
    ),
  ],
);
