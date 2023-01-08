import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/usecases/find_users_usecase.dart';
import 'package:git_search/src/infra/models/user_model.dart';
import 'package:git_search/src/presenter/cubits/list_users/list_users_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_users/list_users_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mocks/user_json.dart';

class FindUsersUsecaseMock extends Mock implements FindUsersUsecase {}

void main() {
  late FindUsersUsecaseMock findUsersUsecase;
  late ListUsersCubit listUsersCubit;

  setUp(() {
    findUsersUsecase = FindUsersUsecaseMock();
    listUsersCubit = ListUsersCubit(findUsersUsecase: findUsersUsecase);
  });

  test('should find users', () async {
    final user = UserModel.fromMap(jsonDecode(userJson));
    when(() => findUsersUsecase(query: 'fldnascimento'))
        .thenAnswer((_) async => Success(<UserModel>[user]));

    await listUsersCubit.findUsers('fldnascimento');
    expect(listUsersCubit.state, ListUsersSuccessState(users: [user]));
  });
}
