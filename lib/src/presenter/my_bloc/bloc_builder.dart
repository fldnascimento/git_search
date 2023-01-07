import 'package:flutter/material.dart';

import '../../injection_container.dart';
import 'cubit.dart';

typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);

class BlocBuilder<B extends Cubit<S>, S> extends StatelessWidget {
  final BlocWidgetBuilder<S> builder;
  final B? bloc;

  const BlocBuilder({
    super.key,
    required this.builder,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<S>(
      valueListenable: bloc ?? getIt<B>(),
      builder: (context, value, child) => builder(context, value),
    );
  }
}
