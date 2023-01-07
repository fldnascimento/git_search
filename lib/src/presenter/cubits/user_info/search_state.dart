import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object?> get props => [];
}

class UserInfoInitialState extends UserInfoState {}

class UserInfoLoadingState extends UserInfoState {}

class UserInfoFailureState extends UserInfoState {
  final String errorMessage;
  const UserInfoFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class UserInfoSuccessState extends UserInfoState {
  final UserEntity user;
  const UserInfoSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}
