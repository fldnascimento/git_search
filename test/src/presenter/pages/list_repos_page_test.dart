import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:git_search/src/injection_container.dart' as di;

import '../../../git_search_test_widget.dart';
import '../../../mocks/repos_json.dart';
import '../../../mocks/repos_not_found_json.dart';

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
    'should render list repos on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(reposJson),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-repos/whaticket',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('whaticket'), findsWidgets);
      expect(find.text('canove'), findsOneWidget);
      expect(find.text('whaticket-community'), findsOneWidget);
      expect(find.text('789'), findsOneWidget);
    },
  );

  testWidgets(
    'should render repos not found on page',
    (WidgetTester tester) async {
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonDecode(reposNotFoundJson),
        ),
      );

      await tester.pumpWidget(
        GitSerachTestWidget(
          route: '/list-repos/whaticket',
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
          route: '/list-repos/whaticket',
          dio: dio,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(ErrorsMessages.errorUnknown), findsOneWidget);
    },
  );
}
