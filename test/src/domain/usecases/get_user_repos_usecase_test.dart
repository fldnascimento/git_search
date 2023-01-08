import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';
import 'package:git_search/src/domain/usecases/get_user_repos_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class GitHubRepositoryMock extends Mock implements GitHubRepository {}

void main() {
  late GitHubRepositoryMock repository;
  late GetUserReposUsecaseImpl usecase;

  setUp(() {
    repository = GitHubRepositoryMock();
    usecase = GetUserReposUsecaseImpl(gitHubRepository: repository);
  });

  sucessMock() {
    when(() => repository.getUserRepos(login: any(named: 'login')))
        .thenAnswer((_) async => const Success(<RepoEntity>[]));
  }

  test('should call repository.getUserRepos', () async {
    sucessMock();
    await usecase(login: 'fldnascimento');
    verify(() => repository.getUserRepos(login: any(named: 'login'))).called(1);
  });

  test('should return a empty list of repos', () async {
    sucessMock();
    final result = await usecase(login: 'fldnascimento');
    expect(result.getOrNull(), isA<List<RepoEntity>>());
  });

  test('should return a ParamEmpty when query is empty', () async {
    when(() => repository.getUserRepos(login: any(named: 'login')))
        .thenAnswer((_) async => const Failure(ParamEmpty()));
    final result = await usecase(login: '');
    expect(result.fold((s) => s, (f) => f), isA<ParamEmpty>());
  });
}
