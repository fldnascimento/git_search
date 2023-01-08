import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

abstract class ListUsersState extends Equatable {
  const ListUsersState();

  @override
  List<Object?> get props => [];
}

class ListUsersLoadingState extends ListUsersState {}

class ListUsersFailureState extends ListUsersState {
  final String message;
  const ListUsersFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ListUsersSuccessState extends ListUsersState {
  final List<UserEntity> users;
  const ListUsersSuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}
