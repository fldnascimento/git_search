import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../style/app_theme.dart';
import '../style/sizes.dart';
import '../style/spacing.dart';
import '../widgets/user_detail_widget.dart';

class UserProfileWidget extends StatelessWidget {
  final UserEntity user;

  const UserProfileWidget({
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
        const SizedBox(height: Spacing.stackMedium),
        Text(
          user.name ?? user.login,
          style: context.textTheme.headline3?.copyWith(
            color: context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          user.login,
          style: context.textTheme.headline5?.copyWith(
            color: context.colorScheme.outline,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Spacing.stackMedium),
        Visibility(
          visible: user.bio != null,
          child: Column(
            children: [
              Text(
                user.bio ?? '',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.stackMedium),
            ],
          ),
        ),
        Card(
          elevation: Sizes.pico,
          child: Padding(
            padding: const EdgeInsets.all(Spacing.insetMedium),
            child: Column(
              children: [
                Visibility(
                  visible: user.company != null,
                  child: UserDetailWidget(
                    icon: Icons.apartment,
                    label: user.company ?? '',
                  ),
                ),
                const SizedBox(height: Spacing.stackExtraSmall),
                Visibility(
                  visible: user.location != null,
                  child: UserDetailWidget(
                    icon: Icons.pin_drop,
                    label: user.location ?? '',
                  ),
                ),
                const SizedBox(height: Spacing.stackExtraSmall),
                Visibility(
                  visible: visibilityFollowersAndFollowing,
                  child: UserDetailWidget(
                    icon: Icons.group,
                    label: followersAndFollowing,
                  ),
                ),
                const SizedBox(height: Spacing.stackExtraSmall),
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
        const SizedBox(height: Spacing.stackMedium),
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
