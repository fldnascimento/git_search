import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
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

  test('should get user repos', () async {
    final repo = RepoModel.fromMap(jsonDecode(repoJson));
    when(() => getUserReposUsecase(login: 'fldnascimento'))
        .thenAnswer((_) async => Success(<RepoModel>[repo]));

    await listReposUserCubit.getUserRepos('fldnascimento');
    expect(listReposUserCubit.state, ListReposUserSuccessState(repos: [repo]));
  });

  test('should get repos starred', () async {
    final repo = RepoModel.fromMap(jsonDecode(repoJson));
    when(() => getReposStarredUsecase(login: 'fldnascimento'))
        .thenAnswer((_) async => Success(<RepoModel>[repo]));

    await listReposUserCubit.getReposStarred('fldnascimento');
    expect(listReposUserCubit.state, ListReposUserSuccessState(repos: [repo]));
  });
}
