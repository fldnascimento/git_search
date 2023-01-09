import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../style/app_theme.dart';
import '../style/breakpoints.dart';
import '../style/spacing.dart';
import '../widgets/search_option_widget.dart';

class ContainerSearchWidget extends StatelessWidget {
  final String query;
  const ContainerSearchWidget({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.desktopMaxWidth,
        ),
        color: context.colorScheme.surface,
        padding: const EdgeInsets.all(Spacing.insetMedium),
        child: Column(
          children: [
            SearchOptionWidget(
              icon: Icons.group,
              label: 'Usuários com',
              query: query,
              onTap: () => context.push('/list-users/$query'),
            ),
            const SizedBox(height: Spacing.stackLarge),
            SearchOptionWidget(
              icon: Icons.folder_copy,
              label: 'Repositórios com',
              query: query,
              onTap: () => context.push('/list-repos/$query'),
            ),
            const SizedBox(height: Spacing.stackLarge),
            SearchOptionWidget(
              icon: Icons.arrow_forward,
              label: 'Pular para',
              query: query,
              onTap: () => context.push('/user/$query'),
            ),
          ],
        ),
      ),
    );
  }
}
