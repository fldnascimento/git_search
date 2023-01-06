import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/external/datasources/git_hub_datasource_impl.dart';
import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/infra/models/user_model.dart';

import '../../../mocks/repos_json.dart';
import '../../../mocks/repos_starred_json.dart';
import '../../../mocks/user_json.dart';
import '../../../mocks/users_json.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late GitHubDatasourceImpl datasource;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
    datasource = GitHubDatasourceImpl(dio: dio);
  });

  successMock(String json) {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: jsonDecode(json),
      ),
    );
  }

  errorMock(DioErrorType type) {
    when(() => dio.get(any())).thenThrow(
      DioError(
        requestOptions: RequestOptions(path: ''),
        type: type,
      ),
    );
  }

  group('findRepos -', () {
    test('should call dio.get', () async {
      successMock(reposJson);
      await datasource.findRepos(query: 'repo');
      verify(() => dio.get(any())).called(1);
    });

    test('should find repos', () async {
      successMock(reposJson);
      final result = await datasource.findRepos(query: 'repo');
      expect(result, isA<List<RepoModel>>());
    });

    test(
      'should find repos but throws TimeoutConnection when connectTimeout',
      () async {
        errorMock(DioErrorType.connectTimeout);
        final future = datasource.findRepos(query: 'repo');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should find repos but throws TimeoutConnection when receiveTimeout',
      () async {
        errorMock(DioErrorType.receiveTimeout);
        final future = datasource.findRepos(query: 'repo');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should find repos but throws RateLimitExceeded when statusCode 403',
      () async {
        when(() => dio.get(any())).thenThrow(RateLimitExceeded());
        final future = datasource.findRepos(query: 'repo');
        expect(future, throwsA(isA<RateLimitExceeded>()));
      },
    );

    test(
      'should find repos but throws Exception when statusCode is unknown',
      () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: '',
          ),
        );
        final future = datasource.findRepos(query: 'repo');
        expect(future, throwsA(isA<Exception>()));
      },
    );
  });

  group('findUsers -', () {
    test('should call dio.get', () async {
      successMock(usersJson);
      await datasource.findUsers(query: 'user');
      verify(() => dio.get(any())).called(1);
    });

    test('should find users', () async {
      successMock(usersJson);
      final result = await datasource.findUsers(query: 'user');
      expect(result, isA<List<UserModel>>());
    });

    test(
      'should find users but throws TimeoutConnection when connectTimeout',
      () async {
        errorMock(DioErrorType.connectTimeout);
        final future = datasource.findUsers(query: 'user');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should find users but throws TimeoutConnection when receiveTimeout',
      () async {
        errorMock(DioErrorType.receiveTimeout);
        final future = datasource.findUsers(query: 'user');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should find users but throws RateLimitExceeded when statusCode 403',
      () async {
        when(() => dio.get(any())).thenThrow(RateLimitExceeded());
        final future = datasource.findUsers(query: 'user');
        expect(future, throwsA(isA<RateLimitExceeded>()));
      },
    );

    test(
      'should find users but throws Exception when statusCode is unknown',
      () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: '',
          ),
        );
        final future = datasource.findUsers(query: 'user');
        expect(future, throwsA(isA<Exception>()));
      },
    );
  });

  group('getReposStarred -', () {
    test('should call dio.get', () async {
      successMock(reposStarredJson);
      await datasource.getReposStarred(login: 'login');
      verify(() => dio.get(any())).called(1);
    });

    test('should get repos starred', () async {
      successMock(reposStarredJson);
      final result = await datasource.getReposStarred(login: 'login');
      expect(result, isA<List<RepoModel>>());
    });

    test(
      'should get repos starred but throws TimeoutConnection when connectTimeout',
      () async {
        errorMock(DioErrorType.connectTimeout);
        final future = datasource.getReposStarred(login: 'login');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should get repos starred but throws TimeoutConnection when receiveTimeout',
      () async {
        errorMock(DioErrorType.receiveTimeout);
        final future = datasource.getReposStarred(login: 'login');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should get repos starred but throws RateLimitExceeded when statusCode 403',
      () async {
        when(() => dio.get(any())).thenThrow(RateLimitExceeded());
        final future = datasource.getReposStarred(login: 'login');
        expect(future, throwsA(isA<RateLimitExceeded>()));
      },
    );

    test(
      'should get repos starred but throws Exception when statusCode is unknown',
      () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: '',
          ),
        );
        final future = datasource.getReposStarred(login: 'login');
        expect(future, throwsA(isA<Exception>()));
      },
    );
  });

  group('getUser -', () {
    test('should call dio.get', () async {
      successMock(userJson);
      await datasource.getUser(login: 'login');
      verify(() => dio.get(any())).called(1);
    });

    test('should get user', () async {
      successMock(userJson);
      final result = await datasource.getUser(login: 'login');
      expect(result, isA<UserModel>());
    });

    test(
      'should get user but throws TimeoutConnection when connectTimeout',
      () async {
        errorMock(DioErrorType.connectTimeout);
        final future = datasource.getUser(login: 'login');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should get user but throws TimeoutConnection when receiveTimeout',
      () async {
        errorMock(DioErrorType.receiveTimeout);
        final future = datasource.getUser(login: 'login');
        expect(future, throwsA(isA<TimeoutConnection>()));
      },
    );

    test(
      'should get user but throws RateLimitExceeded when statusCode 403',
      () async {
        when(() => dio.get(any())).thenThrow(RateLimitExceeded());
        final future = datasource.getUser(login: 'login');
        expect(future, throwsA(isA<RateLimitExceeded>()));
      },
    );

    test(
      'should get user but throws Exception when statusCode is unknown',
      () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: '',
          ),
        );
        final future = datasource.getUser(login: 'login');
        expect(future, throwsA(isA<Exception>()));
      },
    );
  });
}
