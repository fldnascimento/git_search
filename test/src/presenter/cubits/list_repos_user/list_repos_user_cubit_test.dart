import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:git_search/src/domain/usecases/get_repos_starred_usecase.dart';
import 'package:git_search/src/domain/usecases/get_user_repos_usecase.dart';
import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/presenter/cubits/list_repos_user/list_repos_user_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_repos_user/list_repos_user_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mocks/repo_json.dart';

class GetUserReposUsecaseMock extends Mock implements GetUserReposUsecase {}

class GetReposStarredUsecaseMock extends Mock
    implements GetReposStarredUsecase {}

void main() {
  late GetUserReposUsecaseMock getUserReposUsecase;
  late GetReposStarredUsecaseMock getReposStarredUsecase;
  late ListReposUserCubit listReposUserCubit;

  setUp(() {
    getUserReposUsecase = GetUserReposUsecaseMock();
    getReposStarredUsecase = GetReposStarredUsecaseMock();
    listReposUserCubit = ListReposUserCubit(
      getReposStarredUsecase: getReposStarredUsecase,
      getUserReposUsecase: getUserReposUsecase,
    );
  });

  group('getUserRepos -', () {
    test('should emit state ListReposUserLoadingState', () async {
      when(() => getUserReposUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => const Failure(ReposNotFound()));
      listReposUserCubit.getUserRepos('fldnascimento');
      expect(listReposUserCubit.state, ListReposUserLoadingState());
    });

    test('should emit state ListReposUserSuccessState', () async {
      final repo = RepoModel.fromMap(jsonDecode(repoJson));
      when(() => getUserReposUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => Success(<RepoModel>[repo]));

      await listReposUserCubit.getUserRepos('fldnascimento');
      expect(
        listReposUserCubit.state,
        ListReposUserSuccessState(repos: [repo]),
      );
    });

    test(
      'should emit state ListReposUserFailureState when repos not found',
      () async {
        when(() => getUserReposUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(ReposNotFound()));

        await listReposUserCubit.getUserRepos('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(
            message: ErrorsMessages.reposNotFound,
          ),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when rate limit exceeded',
      () async {
        when(() => getUserReposUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(RateLimitExceeded()));

        await listReposUserCubit.getUserRepos('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(
            message: ErrorsMessages.rateLimitExceeded,
          ),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when timeout connection',
      () async {
        when(() => getUserReposUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(TimeoutConnection()));

        await listReposUserCubit.getUserRepos('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(
            message: ErrorsMessages.timeoutConnection,
          ),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when empty param',
      () async {
        when(() => getUserReposUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(ParamEmpty()));

        await listReposUserCubit.getUserRepos('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(message: ErrorsMessages.paramEmpty),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when error unknown',
      () async {
        when(() => getUserReposUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(ErrorUnknown()));

        await listReposUserCubit.getUserRepos('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(message: ErrorsMessages.errorUnknown),
        );
      },
    );
  });

  group('getReposStarred -', () {

    test('should emit state ListReposUserLoadingState', () async {
      when(() => getReposStarredUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => const Failure(ReposNotFound()));
      listReposUserCubit.getReposStarred('fldnascimento');
      expect(listReposUserCubit.state, ListReposUserLoadingState());
    });

    test('should emit state ListReposUserSuccessState', () async {
      final repo = RepoModel.fromMap(jsonDecode(repoJson));
      when(() => getReposStarredUsecase(login: 'fldnascimento'))
          .thenAnswer((_) async => Success(<RepoModel>[repo]));

      await listReposUserCubit.getReposStarred('fldnascimento');
      expect(
        listReposUserCubit.state,
        ListReposUserSuccessState(
          repos: [repo],
        ),
      );
    });

    test(
      'should emit state ListReposUserFailureState when repos starred not found',
      () async {
        when(() => getReposStarredUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(ReposNotFound()));

        await listReposUserCubit.getReposStarred('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(
            message: ErrorsMessages.reposNotFound,
          ),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when rate limit exceeded',
      () async {
        when(() => getReposStarredUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(RateLimitExceeded()));

        await listReposUserCubit.getReposStarred('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(
            message: ErrorsMessages.rateLimitExceeded,
          ),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when timeout connection',
      () async {
        when(() => getReposStarredUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(TimeoutConnection()));

        await listReposUserCubit.getReposStarred('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(
            message: ErrorsMessages.timeoutConnection,
          ),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when empty param',
      () async {
        when(() => getReposStarredUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(ParamEmpty()));

        await listReposUserCubit.getReposStarred('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(message: ErrorsMessages.paramEmpty),
        );
      },
    );

    test(
      'should emit state ListReposUserFailureState when error unknown',
      () async {
        when(() => getReposStarredUsecase(login: any(named: 'login')))
            .thenAnswer((_) async => const Failure(ErrorUnknown()));

        await listReposUserCubit.getReposStarred('fldnascimento');
        expect(
          listReposUserCubit.state,
          const ListReposUserFailureState(message: ErrorsMessages.errorUnknown),
        );
      },
    );
  });
}
