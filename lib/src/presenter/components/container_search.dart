import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContainerSearch extends StatelessWidget {
  final String query;
  const ContainerSearch({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchOption(
            icon: Icons.account_circle_rounded,
            label: 'Usuários com',
            query: query,
            onTap: () => context.push('/list-users/$query'),
          ),
          const SizedBox(height: 16),
          SearchOption(
            icon: Icons.book,
            label: 'Repositórios com',
            query: query,
            onTap: () => context.push('/list-repos/$query'),
          ),
          const SizedBox(height: 16),
          SearchOption(
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

class SearchOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String query;
  final Function()? onTap;

  const SearchOption({
    super.key,
    required this.icon,
    required this.label,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF444444),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              '$label "$query"',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
