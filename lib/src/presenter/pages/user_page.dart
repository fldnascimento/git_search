import 'package:flutter/material.dart';
import 'package:git_search/src/domain/entities/user_entity.dart';

class UserPage extends StatelessWidget {
  final UserEntity user;

  const UserPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Usuários'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              title: Text(user.login),
              subtitle: Text(user.bio ?? ''),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
