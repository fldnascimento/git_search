import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../injection_container.dart';
import '../cubits/list_repos/list_repos_cubit.dart';
import '../cubits/list_repos/list_repos_state.dart';
import '../my_bloc/bloc_builder.dart';
import '../widgets/failure_widget.dart';
import '../widgets/list_tile_repos.dart';
import '../widgets/progress_indicator_widget.dart';

class ListReposPage extends StatefulWidget {
  final String query;

  const ListReposPage({
    super.key,
    required this.query,
  });

  @override
  State<ListReposPage> createState() => _ListReposPageState();
}

class _ListReposPageState extends State<ListReposPage> {
  @override
  void initState() {
    super.initState();
    getIt<ListReposCubit>().findRepos(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.query),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ListReposCubit, ListReposState>(
            bloc: getIt<ListReposCubit>(),
            builder: (context, state) {
              if (state is ListReposLoadingState) {
                return const ProgressIndicatorWidget();
              }

              if (state is ListReposFailureState) {
                return FailureWidget(message: state.message);
              }

              if (state is ListReposSuccessState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.repos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final repo = state.repos[index];

                      return ListTileRepos(
                        onTap: () {
                          context.push('/user/${repo.owner.login}');
                        },
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
