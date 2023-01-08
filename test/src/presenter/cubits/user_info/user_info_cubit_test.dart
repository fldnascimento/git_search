import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:git_search/src/domain/usecases/get_user_usecase.dart';
import 'package:git_search/src/infra/models/user_model.dart';
import 'package:git_search/src/presenter/cubits/user_info/search_cubit.dart';
import 'package:git_search/src/presenter/cubits/user_info/search_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mocks/user_json.dart';

class GetUserUsecaseMock extends Mock implements GetUserUsecase {}

void main() {
  late GetUserUsecaseMock getUserUsecase;
  late UserInfoCubit userInfoCubit;

  setUp(() {
    getUserUsecase = GetUserUsecaseMock();
    userInfoCubit = UserInfoCubit(getUserUsecase: getUserUsecase);
  });

  test('should emit state UserInfoLoadingState', () async {
    when(() => getUserUsecase(login: any(named: 'login')))
        .thenAnswer((_) async => const Failure(UserNotFound()));
    userInfoCubit.getUser('fldnascimento');
    expect(userInfoCubit.state, UserInfoLoadingState());
  });

  test('should emit state UserInfoSuccessState', () async {
    final user = UserModel.fromMap(jsonDecode(userJson));
    when(() => getUserUsecase(login: any(named: 'login')))
        .thenAnswer((_) async => Success(user));

    await userInfoCubit.getUser('fldnascimento');
    expect(userInfoCubit.state, UserInfoSuccessState(user: user));
  });

  test('should emit state UserInfoFailureState when user not found', () async {
    when(() => getUserUsecase(login: any(named: 'login')))
        .thenAnswer((_) async => const Failure(UserNotFound()));

    await userInfoCubit.getUser('fldnascimento');
    expect(
      userInfoCubit.state,
      const UserInfoFailureState(message: ErrorsMessages.userNotFound),
    );
  });

  test(
    'should emit state UserInfoFailureState when rate limit exceeded',
    () async {
      when(() => getUserUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => const Failure(RateLimitExceeded()));

      await userInfoCubit.getUser('fldnascimento');
      expect(
        userInfoCubit.state,
        const UserInfoFailureState(message: ErrorsMessages.rateLimitExceeded),
      );
    },
  );

  test(
    'should emit state UserInfoFailureState when timeout connection',
    () async {
      when(() => getUserUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => const Failure(TimeoutConnection()));

      await userInfoCubit.getUser('fldnascimento');
      expect(
        userInfoCubit.state,
        const UserInfoFailureState(message: ErrorsMessages.timeoutConnection),
      );
    },
  );
  test(
    'should emit state UserInfoFailureState when empty param',
    () async {
      when(() => getUserUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => const Failure(ParamEmpty()));

      await userInfoCubit.getUser('fldnascimento');
      expect(
        userInfoCubit.state,
        const UserInfoFailureState(message: ErrorsMessages.paramEmpty),
      );
    },
  );

  test(
    'should emit state UserInfoFailureState when error unknown',
    () async {
      when(() => getUserUsecase(login: any(named: 'login')))
          .thenAnswer((_) async => const Failure(ErrorUnknown()));

      await userInfoCubit.getUser('fldnascimento');
      expect(
        userInfoCubit.state,
        const UserInfoFailureState(message: ErrorsMessages.errorUnknown),
      );
    },
  );
}
