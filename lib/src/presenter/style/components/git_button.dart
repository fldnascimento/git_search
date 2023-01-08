import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../sizes.dart';

class GitButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const GitButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: Sizes.giga,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              context.colorScheme.primary,
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
