import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/infra/datasources/git_hub_datasource.dart';
import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/infra/models/user_model.dart';
import 'package:git_search/src/infra/repositories/git_hub_repository_impl.dart';

import '../../../mocks/repo_json.dart';
import '../../../mocks/user_json.dart';

class GitHubDatasourceMock extends Mock implements GitHubDatasource {}

void main() {
  late GitHubDatasourceMock datasource;
  late GitHubRepositoryImpl repository;

  setUp(() {
    datasource = GitHubDatasourceMock();
    repository = GitHubRepositoryImpl(datasource: datasource);
  });

  group('findRepos -', () {
    test('should call datasource.findRepos', () async {
      await repository.findRepos(query: 'repo');
      verify(() => datasource.findRepos(query: any(named: 'query'))).called(1);
    });

    test('should find repos', () async {
      final repo = RepoModel.fromMap(jsonDecode(repoJson));
      when(() => datasource.findRepos(query: any(named: 'query')))
          .thenAnswer((_) async => <RepoModel>[repo]);
      final result = await repository.findRepos(query: 'repo');
      expect(result.getOrNull(), isA<List<RepoEntity>>());
    });

    test('should find repos but throws ReposNotFound', () async {
      when(() => datasource.findRepos(query: any(named: 'query')))
          .thenAnswer((_) async => <RepoModel>[]);
      final result = await repository.findRepos(query: 'repo');
      expect(result.fold((s) => s, (f) => f), isA<ReposNotFound>());
    });

    test('should find repos but throws RateLimitExceeded', () async {
      when(() => datasource.findRepos(query: any(named: 'query')))
          .thenThrow(RateLimitExceeded());
      final result = await repository.findRepos(query: 'repo');
      expect(result.fold((s) => s, (f) => f), isA<RateLimitExceeded>());
    });

    test('should find repos but throws Error', () async {
      when(() => datasource.findRepos(query: any(named: 'query')))
          .thenThrow(const Error());
      final result = await repository.findRepos(query: 'repo');
      expect(result.fold((s) => s, (f) => f), isA<Error>());
    });
  });

  group('findUsers -', () {
    test('should call datasource.findUsers', () async {
      await repository.findUsers(query: 'user');
      verify(() => datasource.findUsers(query: any(named: 'query'))).called(1);
    });

    test('should find users', () async {
      final user = UserModel.fromMap(jsonDecode(userJson));
      when(() => datasource.findUsers(query: any(named: 'query')))
          .thenAnswer((_) async => <UserModel>[user]);
      final result = await repository.findUsers(query: 'user');
      expect(result.getOrNull(), isA<List<UserModel>>());
    });

    test('should find users but throws UsersNotFound', () async {
      when(() => datasource.findUsers(query: any(named: 'query')))
          .thenAnswer((_) async => <UserModel>[]);
      final result = await repository.findUsers(query: 'user');
      expect(result.fold((s) => s, (f) => f), isA<UsersNotFound>());
    });

    test('should find users but throws RateLimitExceeded', () async {
      when(() => datasource.findUsers(query: any(named: 'query')))
          .thenThrow(RateLimitExceeded());
      final result = await repository.findUsers(query: 'user');
      expect(result.fold((s) => s, (f) => f), isA<RateLimitExceeded>());
    });

    test('should find users but throws Error', () async {
      when(() => datasource.findUsers(query: any(named: 'query')))
          .thenThrow(const Error());
      final result = await repository.findUsers(query: 'user');
      expect(result.fold((s) => s, (f) => f), isA<Error>());
    });
  });

  group('getReposStarred -', () {
    test('should call datasource.getReposStarred', () async {
      await repository.getReposStarred(login: 'login');
      verify(() => datasource.getReposStarred(login: any(named: 'login')))
          .called(1);
    });

    test('should get repos starred', () async {
      final repo = RepoModel.fromMap(jsonDecode(repoJson));
      when(() => datasource.getReposStarred(login: any(named: 'login')))
          .thenAnswer((_) async => <RepoModel>[repo]);
      final result = await repository.getReposStarred(login: 'login');
      expect(result.getOrNull(), isA<List<RepoModel>>());
    });

    test('should get repos starred but throws ReposNotFound', () async {
      when(() => datasource.getReposStarred(login: any(named: 'login')))
          .thenAnswer((_) async => <RepoModel>[]);
      final result = await repository.getReposStarred(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<ReposNotFound>());
    });

    test('should get repos starred but throws RateLimitExceeded', () async {
      when(() => datasource.getReposStarred(login: any(named: 'login')))
          .thenThrow(RateLimitExceeded());
      final result = await repository.getReposStarred(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<RateLimitExceeded>());
    });

    test('should get repos starred but throws Error', () async {
      when(() => datasource.getReposStarred(login: any(named: 'login')))
          .thenThrow(const Error());
      final result = await repository.getReposStarred(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<Error>());
    });
  });

  group('getUser -', () {
    test('should call datasource.getUser', () async {
      await repository.getUser(login: 'login');
      verify(() => datasource.getUser(login: any(named: 'login'))).called(1);
    });

    test('should get user', () async {
      final user = UserModel.fromMap(jsonDecode(userJson));
      when(() => datasource.getUser(login: any(named: 'login')))
          .thenAnswer((_) async => user);
      final result = await repository.getUser(login: 'login');
      expect(result.getOrNull(), isA<UserModel>());
    });

    test('should get user but throws UserNotFound', () async {
      when(() => datasource.getUser(login: any(named: 'login')))
          .thenThrow(UserNotFound());
      final result = await repository.getUser(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<UserNotFound>());
    });

    test('should get user but throws RateLimitExceeded', () async {
      when(() => datasource.getUser(login: any(named: 'login')))
          .thenThrow(RateLimitExceeded());
      final result = await repository.getUser(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<RateLimitExceeded>());
    });

    test('should get user but throws Error', () async {
      when(() => datasource.getUser(login: any(named: 'login')))
          .thenThrow(const Error());
      final result = await repository.getUser(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<Error>());
    });
  });

  group('getUserRepos -', () {
    test('should call datasource.getUserRepos', () async {
      await repository.getUserRepos(login: 'login');
      verify(() => datasource.getUserRepos(login: any(named: 'login')))
          .called(1);
    });

    test('should get user repos', () async {
      final repo = RepoModel.fromMap(jsonDecode(repoJson));
      when(() => datasource.getUserRepos(login: any(named: 'login')))
          .thenAnswer((_) async => [repo]);
      final result = await repository.getUserRepos(login: 'login');
      expect(result.getOrNull(), isA<List<RepoModel>>());
    });

    test('should get user repos but throws ReposNotFound', () async {
      when(() => datasource.getUserRepos(login: any(named: 'login')))
          .thenThrow(const ReposNotFound());
      final result = await repository.getUserRepos(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<ReposNotFound>());
    });

    test('should get user repos but throws RateLimitExceeded', () async {
      when(() => datasource.getUserRepos(login: any(named: 'login')))
          .thenThrow(RateLimitExceeded());
      final result = await repository.getUserRepos(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<RateLimitExceeded>());
    });

    test('should get user repos but throws Error', () async {
      when(() => datasource.getUserRepos(login: any(named: 'login')))
          .thenThrow(const Error());
      final result = await repository.getUserRepos(login: 'login');
      expect(result.fold((s) => s, (f) => f), isA<Error>());
    });
  });
}
