import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:git_search/src/injection_container.dart' as di;

import '../../../git_search_test_widget.dart';
import '../../../mocks/users_json.dart';
import '../../../mocks/users_not_found_json.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late DioMock dio;

  setUpAll(() {
    HttpOverrides.global = null;
  });

  setUp(() async {
    dio = DioMock();
    await di.getIt.reset();
    di.setup();
  });

  testWidgets(
    'should render list users on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(usersJson),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-users/felipe',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Usuários'), findsOneWidget);
      expect(find.text('felipe'), findsOneWidget);
      expect(find.text('felipefialho'), findsOneWidget);
      expect(find.text('felipecsl'), findsOneWidget);
    },
  );

  testWidgets(
    'should render users not found on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(usersNotFoundJson),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-users/felipe',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.usersNotFound), findsOneWidget);
    },
  );

  testWidgets(
    'should render error unknown on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: '',
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-users/felipe',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.errorUnknown), findsOneWidget);
    },
  );
}
