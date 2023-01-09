import 'package:flutter/material.dart';

import '../style/app_theme.dart';
import '../style/spacing.dart';

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
        const SizedBox(width: Spacing.inlineExtraSmall),
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
