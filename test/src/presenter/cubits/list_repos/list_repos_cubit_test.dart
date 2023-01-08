import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
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

  test('should find repos', () async {
    final repo = RepoModel.fromMap(jsonDecode(repoJson));
    when(() => findReposUsecase(query: 'fldnascimento'))
        .thenAnswer((_) async => Success(<RepoModel>[repo]));

    await listReposCubit.findRepos('fldnascimento');
    expect(listReposCubit.state, ListReposSuccessState(repos: [repo]));
  });
}
