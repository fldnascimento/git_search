import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/usecases/get_user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';

class GitHubRepositoryMock extends Mock implements GitHubRepository {}

void main() {
  late GitHubRepositoryMock repository;
  late GetUserUsecaseImpl usecase;

  setUp(() {
    repository = GitHubRepositoryMock();
    usecase = GetUserUsecaseImpl(gitHubRepository: repository);
  });

  test('should call repository.getUser', () async {
    when(() => repository.getUser(login: any(named: 'login')))
        .thenAnswer((_) async => const Failure(UserNotFound()));
    await usecase(login: 'fldnascimento');
    verify(() => repository.getUser(login: any(named: 'login'))).called(1);
  });

  test('should return a user not found', () async {
    when(() => repository.getUser(login: any(named: 'login')))
        .thenAnswer((_) async => const Failure(UserNotFound()));
    final result = await usecase(login: 'fldnascimento');
    expect(result.fold((s) => s, (f) => f), isA<UserNotFound>());
  });

  test('should return a ParamEmpty when query is empty', () async {
    when(() => repository.getUser(login: any(named: 'login')))
        .thenAnswer((_) async => const Failure(ParamEmpty()));
    final result = await usecase(login: '');
    expect(result.fold((s) => s, (f) => f), isA<ParamEmpty>());
  });
}
