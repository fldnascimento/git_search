import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Cubit<T> extends ValueNotifier<T> {
  Cubit(super.value);

  emit(T state) {
    if (!kIsWeb && Platform.environment.containsKey('FLUTTER_TEST')) {
      value = state;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        value = state;
      });
    }
  }

  T get state => value;
}
