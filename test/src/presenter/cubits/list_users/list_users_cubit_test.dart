import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
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

  test('should emit state ListUsersLoadingState', () async {
    when(() => findUsersUsecase(query: any(named: 'query')))
        .thenAnswer((_) async => const Failure(UsersNotFound()));
    listUsersCubit.findUsers('fldnascimento');
    expect(listUsersCubit.state, ListUsersLoadingState());
  });

  test('should emit state ListUsersSuccessState', () async {
    final user = UserModel.fromMap(jsonDecode(userJson));
    when(() => findUsersUsecase(query: any(named: 'query')))
        .thenAnswer((_) async => Success(<UserModel>[user]));

    await listUsersCubit.findUsers('fldnascimento');
    expect(listUsersCubit.state, ListUsersSuccessState(users: [user]));
  });

  test(
    'should emit state ListUsersFailureState when users not found',
    () async {
      when(() => findUsersUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(UsersNotFound()));

      await listUsersCubit.findUsers('fldnascimento');
      expect(
        listUsersCubit.state,
        const ListUsersFailureState(message: ErrorsMessages.usersNotFound),
      );
    },
  );

  test(
    'should emit state ListUsersFailureState when rate limit exceeded',
    () async {
      when(() => findUsersUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(RateLimitExceeded()));

      await listUsersCubit.findUsers('fldnascimento');
      expect(
        listUsersCubit.state,
        const ListUsersFailureState(message: ErrorsMessages.rateLimitExceeded),
      );
    },
  );

  test(
    'should emit state ListUsersFailureState when timeout connection',
    () async {
      when(() => findUsersUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(TimeoutConnection()));

      await listUsersCubit.findUsers('fldnascimento');
      expect(
        listUsersCubit.state,
        const ListUsersFailureState(message: ErrorsMessages.timeoutConnection),
      );
    },
  );

  test(
    'should emit state ListUsersFailureState when empty param',
    () async {
      when(() => findUsersUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(ParamEmpty()));

      await listUsersCubit.findUsers('fldnascimento');
      expect(
        listUsersCubit.state,
        const ListUsersFailureState(message: ErrorsMessages.paramEmpty),
      );
    },
  );

  test(
    'should emit state ListUsersFailureState when error unknown',
    () async {
      when(() => findUsersUsecase(query: any(named: 'query')))
          .thenAnswer((_) async => const Failure(ErrorUnknown()));

      await listUsersCubit.findUsers('fldnascimento');
      expect(
        listUsersCubit.state,
        const ListUsersFailureState(message: ErrorsMessages.errorUnknown),
      );
    },
  );
}
