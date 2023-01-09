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
    'should render search page',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const GitSerachTestWidget(route: '/search'),
      );

      await tester.pumpAndSettle();

      expect(find.text('Pesquise no Github'), findsOneWidget);
      expect(
        find.text('Pesquise em todo o Github por Usuários e Repositórios'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'should render container search widget on page',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const GitSerachTestWidget(route: '/search'),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "felipe");
      await tester.pump();

      expect(find.text('Usuários com "felipe"'), findsOneWidget);
      expect(find.text('Repositórios com "felipe"'), findsOneWidget);
      expect(find.text('Pular para "felipe"'), findsOneWidget);
    },
  );
}
