import 'package:equatable/equatable.dart';

import '../../../domain/entities/repo_entity.dart';
import '../../../domain/entities/user_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchFailureState extends SearchState {
  final String errorMessage;
  const SearchFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class SearchUsersSuccessState extends SearchState {
  final List<UserEntity> users;
  const SearchUsersSuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}

class SearchReposSuccessState extends SearchState {
  final List<RepoEntity> repos;
  const SearchReposSuccessState({required this.repos});

  @override
  List<Object?> get props => [repos];
}

class SearchUserSuccessState extends SearchState {
  final UserEntity user;
  const SearchUserSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}
