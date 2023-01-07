import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_search/src/domain/entities/user_entity.dart';
import 'package:git_search/src/injection_container.dart';
import 'package:git_search/src/presenter/cubits/search/search_cubit.dart';

import 'user_page.dart';

class UsersPage extends StatelessWidget {
  final List<UserEntity> users;

  const UsersPage({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: users.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return ListTile(
              onTap: () async {
                final user = users[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserPage(user: user),
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(users[index].avatarUrl),
              ),
              title: Text(users[index].login),
              subtitle: Text(users[index].bio ?? ''),
            );
          }),
        ),
      ),
    );
  }
}
