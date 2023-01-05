import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';
import 'package:git_search/src/domain/usecases/find_repos_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class GitHubRepositoryMock extends Mock implements GitHubRepository {}

void main() {
  late GitHubRepositoryMock repository;
  late FindReposUsecaseImpl usecase;

  setUp(() {
    repository = GitHubRepositoryMock();
    usecase = FindReposUsecaseImpl(gitHubRepository: repository);
  });

  sucessMock() {
    when(() => repository.findRepos(query: any(named: 'query')))
        .thenAnswer((_) async => const Success(<RepoEntity>[]));
  }

  test('should call repository.findRepos', () async {
    sucessMock();
    await usecase(query: 'fldnascimento');
    verify(() => repository.findRepos(query: any(named: 'query'))).called(1);
  });

  test('should return a empty list of repos', () async {
    sucessMock();
    final result = await usecase(query: 'fldnascimento');
    expect(result.getOrNull(), isA<List<RepoEntity>>());
  });

  test('should return a ParamEmpty when query is empty', () async {
    when(() => repository.findRepos(query: any(named: 'query')))
        .thenAnswer((_) async => Failure(ParamEmpty()));
    final result = await usecase(query: '');
    expect(result.fold((s) => s, (f) => f), isA<ParamEmpty>());
  });
}
