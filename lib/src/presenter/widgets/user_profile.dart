import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../style/app_theme.dart';
import '../widgets/user_detail_widget.dart';

class UserProfile extends StatelessWidget {
  final UserEntity user;

  const UserProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(
            user.avatarUrl,
            width: 300,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.name ?? user.login,
          style: context.textTheme.headline3?.copyWith(
            color: context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          user.login,
          style: context.textTheme.headline5?.copyWith(
            color: context.colorScheme.outline,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Visibility(
          visible: user.bio != null,
          child: Column(
            children: [
              Text(
                user.bio ?? '',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Visibility(
                  visible: user.company != null,
                  child: UserDetailWidget(
                    icon: Icons.apartment,
                    label: user.company ?? '',
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: user.location != null,
                  child: UserDetailWidget(
                    icon: Icons.pin_drop,
                    label: user.location ?? '',
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: visibilityFollowersAndFollowing,
                  child: UserDetailWidget(
                    icon: Icons.group,
                    label: followersAndFollowing,
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: user.publicRepos != null,
                  child: UserDetailWidget(
                    icon: Icons.folder_copy,
                    label: publicRepos,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String get publicRepos {
    int repos = user.publicRepos ?? 0;

    return '$repos Repositórios públicos';
  }

  bool get visibilityFollowersAndFollowing {
    return user.following != null || user.followers != null;
  }

  String get followersAndFollowing {
    if (user.following != null || user.followers != null) {
      return '${user.followers} seguidores ▪️ ${user.following} seguindo';
    }

    return '';
  }
}
