import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../injection_container.dart';
import '../cubits/list_users/list_users_cubit.dart';
import '../cubits/list_users/list_users_state.dart';
import '../my_bloc/bloc_builder.dart';
import '../style/app_theme.dart';

class ListUsersPage extends StatefulWidget {
  final String query;

  const ListUsersPage({
    super.key,
    required this.query,
  });

  @override
  State<ListUsersPage> createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  @override
  void initState() {
    getIt<ListUsersCubit>().findUsers(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ListUsersCubit, ListUsersState>(
            bloc: getIt<ListUsersCubit>(),
            builder: (context, state) {
              if (state is ListUsersLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ListUsersFailureState) {
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

              if (state is ListUsersSuccessState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final user = state.users[index];

                      return ListTile(
                        onTap: () async {
                          context.push('/user/${user.login}');
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            user.avatarUrl,
                            width: 50,
                          ),
                        ),
                        title: Text(
                          user.login,
                          style: context.textTheme.subtitle1,
                        ),
                        subtitle: Text(user.name ?? ''),
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
