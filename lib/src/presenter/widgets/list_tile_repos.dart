import 'package:flutter/material.dart';

import '../../domain/entities/repo_entity.dart';
import '../style/app_theme.dart';
import '../style/spacing.dart';

class ListTileRepos extends StatelessWidget {
  final void Function()? onTap;
  final RepoEntity repo;

  const ListTileRepos({
    super.key,
    required this.repo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onTap != null)
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(repo.owner.avatarUrl),
                  radius: 10,
                ),
                const SizedBox(width: Spacing.inlineMicro),
                Text(
                  repo.owner.login,
                  style: context.textTheme.subtitle2?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          Text(
            repo.name,
            style: context.textTheme.subtitle1,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repo.description ?? ''),
          const SizedBox(height: Spacing.stackMicro),
          Row(
            children: [
              Icon(
                Icons.star,
                color: context.colorScheme.secondary,
              ),
              const SizedBox(width: Spacing.inlineMicro),
              Text('${repo.stargazersCount}'),
              const SizedBox(width: Spacing.inlineSmall),
              if (repo.language != null && repo.language!.isNotEmpty) ...[
                Icon(
                  Icons.subtitles,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: Spacing.inlineMicro),
                Text(repo.language ?? ''),
              ],
            ],
          ),
          const SizedBox(height: Spacing.stackSmall),
        ],
      ),
    );
  }
}
