import 'package:equatable/equatable.dart';

import '../../../domain/entities/repo_entity.dart';

abstract class ListReposUserState extends Equatable {
  const ListReposUserState();

  @override
  List<Object?> get props => [];
}

class ListReposUserInitialState extends ListReposUserState {}

class ListReposUserLoadingState extends ListReposUserState {}

class ListReposUserFailureState extends ListReposUserState {
  final String errorMessage;
  const ListReposUserFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ListReposUserSuccessState extends ListReposUserState {
  final List<RepoEntity> repos;
  const ListReposUserSuccessState({required this.repos});

  @override
  List<Object?> get props => [repos];
}
