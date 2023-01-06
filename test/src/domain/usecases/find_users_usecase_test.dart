import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:git_search/src/domain/entities/user_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';
import 'package:git_search/src/domain/usecases/find_users_usecase.dart';

class GitHubRepositoryMock extends Mock implements GitHubRepository {}

void main() {
  late GitHubRepositoryMock repository;
  late FindUsersUsecaseImpl usecase;

  setUp(() {
    repository = GitHubRepositoryMock();
    usecase = FindUsersUsecaseImpl(gitHubRepository: repository);
  });

  sucessMock() {
    when(() => repository.findUsers(query: any(named: 'query')))
        .thenAnswer((_) async => const Success(<UserEntity>[]));
  }

  test('should call repository.findUsers', () async {
    sucessMock();
    await usecase(query: 'fldnascimento');
    verify(() => repository.findUsers(query: any(named: 'query'))).called(1);
  });

  test('should return a empty list of users', () async {
    sucessMock();
    final result = await usecase(query: 'fldnascimento');
    expect(result.getOrNull(), isA<List<UserEntity>>());
  });

  test('should return a ParamEmpty when query is empty', () async {
    when(() => repository.findUsers(query: any(named: 'query')))
        .thenAnswer((_) async => Failure(ParamEmpty()));
    final result = await usecase(query: '');
    expect(result.fold((s) => s, (f) => f), isA<ParamEmpty>());
  });
}
