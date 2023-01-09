import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:git_search/src/injection_container.dart' as di;

import '../../../git_search_test_widget.dart';
import '../../../mocks/user_json.dart';

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
    'should render user info on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(userJson),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/user/fldnascimento',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('fldnascimento'), findsWidgets);
      expect(find.text('5 Repositórios públicos'), findsOneWidget);
    },
  );

  testWidgets(
    'should render user not found on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
          data: '',
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/user/fldnascimento',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.userNotFound), findsOneWidget);
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
          route: '/user/fldnascimento',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.errorUnknown), findsOneWidget);
    },
  );
}
