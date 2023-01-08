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
  final String message;
  const UserInfoFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}

class UserInfoSuccessState extends UserInfoState {
  final UserEntity user;
  const UserInfoSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}
