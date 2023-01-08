import 'package:flutter/material.dart';
import 'package:git_search/src/presenter/style/app_theme.dart';

class UserDetailWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  const UserDetailWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: context.textTheme.subtitle2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
