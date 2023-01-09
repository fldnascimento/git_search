import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:git_search/src/injection_container.dart' as di;

import '../../../git_search_test_widget.dart';
import '../../../mocks/user_repos_json.dart';

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
    'should render list repos user on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(userReposJson),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-repos-user/canove/false',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('curso-full-cycle'), findsOneWidget);
      expect(find.text('example_bloc'), findsOneWidget);
    },
  );

  testWidgets(
    'should render repos user not found on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode('[]'),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-repos-user/canove/false',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.reposNotFound), findsOneWidget);
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
          route: '/list-repos-user/canove/false',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.errorUnknown), findsOneWidget);
    },
  );
}
