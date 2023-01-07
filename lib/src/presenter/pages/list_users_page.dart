import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../injection_container.dart';
import '../cubits/list_users/list_users_cubit.dart';
import '../cubits/list_users/list_users_state.dart';
import '../my_bloc/bloc_builder.dart';

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
        backgroundColor: Colors.white,
        title: const Text('Usuários'),
        foregroundColor: Colors.black,
        elevation: 0,
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
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
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
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                        title: Text(user.login),
                        subtitle: Text(user.bio ?? ''),
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
