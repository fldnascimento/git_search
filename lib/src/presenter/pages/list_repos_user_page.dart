import 'package:flutter/material.dart';

import '../../injection_container.dart';
import '../cubits/list_repos_user/list_repos_user_cubit.dart';
import '../cubits/list_repos_user/list_repos_user_state.dart';
import '../my_bloc/bloc_builder.dart';
import '../style/app_theme.dart';
import '../widgets/list_tile_repos.dart';

class ListReposUserPage extends StatefulWidget {
  final String login;
  final bool starred;

  const ListReposUserPage({
    super.key,
    required this.login,
    required this.starred,
  });

  @override
  State<ListReposUserPage> createState() => _ListReposUserPageState();
}

class _ListReposUserPageState extends State<ListReposUserPage> {
  @override
  void initState() {
    super.initState();
    if (widget.starred) {
      getIt<ListReposUserCubit>().getReposStarred(widget.login);
    } else {
      getIt<ListReposUserCubit>().getUserRepos(widget.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.login),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ListReposUserCubit, ListReposUserState>(
            bloc: getIt<ListReposUserCubit>(),
            builder: (context, state) {
              if (state is ListReposUserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ListReposUserFailureState) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: context.textTheme.headline3?.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state is ListReposUserSuccessState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.repos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final repo = state.repos[index];

                      return ListTileRepos(
                        repo: repo,
                      );
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
