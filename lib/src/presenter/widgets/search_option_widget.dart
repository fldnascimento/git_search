import 'package:flutter/material.dart';

import '../style/app_theme.dart';
import '../style/sizes.dart';
import '../style/spacing.dart';

class SearchOptionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String query;
  final Function()? onTap;

  const SearchOptionWidget({
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
          Icon(icon, size: Sizes.large),
          const SizedBox(width: Spacing.inlineMedium),
          Expanded(
            child: Text(
              '$label "$query"',
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
