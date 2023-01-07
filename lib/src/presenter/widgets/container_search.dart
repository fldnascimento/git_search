import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../style/app_theme.dart';
import '../widgets/search_option_widget.dart';

class ContainerSearch extends StatelessWidget {
  final String query;
  const ContainerSearch({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchOptionWidget(
            icon: Icons.account_circle_rounded,
            label: 'Usuários com',
            query: query,
            onTap: () => context.push('/list-users/$query'),
          ),
          const SizedBox(height: 24),
          SearchOptionWidget(
            icon: Icons.book,
            label: 'Repositórios com',
            query: query,
            onTap: () => context.push('/list-repos/$query'),
          ),
          const SizedBox(height: 24),
          SearchOptionWidget(
            icon: Icons.arrow_forward,
            label: 'Pular para',
            query: query,
            onTap: () => context.push('/user/$query'),
          ),
        ],
      ),
    );
  }
}
