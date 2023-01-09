import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:git_search/src/injection_container.dart' as di;

import '../../../git_search_test_widget.dart';

class DioMock extends Mock implements Dio {}

void main() {
  setUp(() async {
    await di.getIt.reset();
    di.setup();
  });

  testWidgets(
    'should render splash page',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const GitSerachTestWidget(route: '/'),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);

    },
  );

}
