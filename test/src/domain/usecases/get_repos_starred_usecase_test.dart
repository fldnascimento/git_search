import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/usecases/get_repos_starred_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';

class GitHubRepositoryMock extends Mock implements GitHubRepository {}

void main() {
  late GitHubRepositoryMock repository;
  late GetReposStarredUsecaseImpl usecase;

  setUp(() {
    repository = GitHubRepositoryMock();
    usecase = GetReposStarredUsecaseImpl(gitHubRepository: repository);
  });

  sucessMock() {
    when(() => repository.getReposStarred(login: any(named: 'login')))
        .thenAnswer((_) async => const Success(<RepoEntity>[]));
  }

  test('should call repository.getReposStarred', () async {
    sucessMock();
    await usecase(login: 'fldnascimento');
    verify(() => repository.getReposStarred(login: any(named: 'login')))
        .called(1);
  });

  test('should return a empty list of repos', () async {
    sucessMock();
    final result = await usecase(login: 'fldnascimento');
    expect(result.getOrNull(), isA<List<RepoEntity>>());
  });

  test('should return a ParamEmpty when query is empty', () async {
    when(() => repository.findRepos(query: any(named: 'query')))
        .thenAnswer((_) async => Failure(ParamEmpty()));
    final result = await usecase(login: '');
    expect(result.fold((s) => s, (f) => f), isA<ParamEmpty>());
  });
}
