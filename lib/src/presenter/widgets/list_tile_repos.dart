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
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          top: Spacing.stackSmall,
          bottom: Spacing.stackSmall,
        ),
        padding: const EdgeInsets.only(
          left: Spacing.inlineMedium,
          right: Spacing.inlineMedium,
        ),
        child: Column(
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
            if (repo.description != null && repo.description!.isNotEmpty)
              Text(
                repo.description ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.colorScheme.outline,
                ),
              ),
            if (repo.description != null && repo.description!.isNotEmpty)
              const SizedBox(height: Spacing.stackMicro),
            Row(
              mainAxisSize: MainAxisSize.min,
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
          ],
        ),
      ),
    );
  }
}
