import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_search/src/injection_container.dart';
import 'package:git_search/src/presenter/cubits/search/search_cubit.dart';

class ContainerSearch extends StatelessWidget {
  final String query;
  const ContainerSearch({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchOption(
            icon: Icons.account_circle_rounded,
            label: 'Usuários com',
            query: query,
            onTap: () => cubit.findUsers(query),
          ),
          const SizedBox(height: 16),
          SearchOption(
            icon: Icons.book,
            label: 'Repositórios com',
            query: query,
            onTap: () => cubit.findRepos(query),
          ),
          const SizedBox(height: 16),
          SearchOption(
            icon: Icons.arrow_forward,
            label: 'Pular para',
            query: query,
            onTap: () => cubit.getUser(query),
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
          Text('$label "$query"'),
        ],
      ),
    );
  }
}
