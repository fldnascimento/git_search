import 'package:flutter/material.dart';
import '../style/app_theme.dart';

class FailureWidget extends StatelessWidget {
  final String message;

  const FailureWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: context.textTheme.headline3?.copyWith(
          color: context.colorScheme.onBackground,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
