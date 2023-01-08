import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:git_search/src/domain/usecases/find_repos_usecase.dart';
import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/presenter/cubits/list_repos/list_repos_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_repos/list_repos_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mocks/repo_json.dart';

class FindReposUsecaseMock extends Mock implements FindReposUsecase {}

void main() {
  late FindReposUsecaseMock findReposUsecase;
  late ListReposCubit listReposCubit;

  setUp(() {
    findReposUsecase = FindReposUsecaseMock();
    listReposCubit = ListReposCubit(findReposUsecase: findReposUsecase);
  });

  test('should emit state ListReposLoadingState', () async {
    when(() => findReposUsecase(query: any(named: 'query')))
        .thenAnswer((_) async => const Failure(ReposNotFound()));
    listReposCubit.findRepos('fldnascimento');
    expect(listReposCubit.state, ListReposLoadingState());
  });

  test('should emit state ListReposSuccessState', () async {
    final repo = RepoModel.fromMap(jsonDecode(repoJson));
    when(() => findReposUsecase(query: 'fldnascimento'))
        .thenAnswer((_) async => Success(<RepoModel>[repo]));

    await listReposCubit.findRepos('fldnascimento');
    expect(listReposCubit.state, ListReposSuccessState(repos: [repo]));
  });

  test(
    'should emit state ListReposFailureState when repos not found',
    () async {
      when(() => findReposUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(ReposNotFound()));

      await listReposCubit.findRepos('fldnascimento');
      expect(
        listReposCubit.state,
        const ListReposFailureState(message: ErrorsMessages.reposNotFound),
      );
    },
  );

  test(
    'should emit state ListReposFailureState when rate limit exceeded',
    () async {
      when(() => findReposUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(RateLimitExceeded()));

      await listReposCubit.findRepos('fldnascimento');
      expect(
        listReposCubit.state,
        const ListReposFailureState(message: ErrorsMessages.rateLimitExceeded),
      );
    },
  );

  test(
    'should emit state ListReposFailureState when timeout connection',
    () async {
      when(() => findReposUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(TimeoutConnection()));

      await listReposCubit.findRepos('fldnascimento');
      expect(
        listReposCubit.state,
        const ListReposFailureState(message: ErrorsMessages.timeoutConnection),
      );
    },
  );

  test(
    'should emit state ListReposFailureState when empty param',
    () async {
      when(() => findReposUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(ParamEmpty()));

      await listReposCubit.findRepos('fldnascimento');
      expect(
        listReposCubit.state,
        const ListReposFailureState(message: ErrorsMessages.paramEmpty),
      );
    },
  );

  test(
    'should emit state ListReposFailureState when error unknown',
    () async {
      when(() => findReposUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(ErrorUnknown()));

      await listReposCubit.findRepos('fldnascimento');
      expect(
        listReposCubit.state,
        const ListReposFailureState(message: ErrorsMessages.errorUnknown),
      );
    },
  );
}
