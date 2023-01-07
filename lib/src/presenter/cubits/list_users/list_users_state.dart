import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

abstract class ListUsersState extends Equatable {
  const ListUsersState();

  @override
  List<Object?> get props => [];
}

class ListUsersInitialState extends ListUsersState {}

class ListUsersLoadingState extends ListUsersState {}

class ListUsersFailureState extends ListUsersState {
  final String errorMessage;
  const ListUsersFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ListUsersSuccessState extends ListUsersState {
  final List<UserEntity> users;
  const ListUsersSuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}
