import 'package:equatable/equatable.dart';

import '../../../domain/entities/repo_entity.dart';

abstract class ListReposState extends Equatable {
  const ListReposState();

  @override
  List<Object?> get props => [];
}

class ListReposInitialState extends ListReposState {}

class ListReposLoadingState extends ListReposState {}

class ListReposFailureState extends ListReposState {
  final String errorMessage;
  const ListReposFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ListReposSuccessState extends ListReposState {
  final List<RepoEntity> repos;
  const ListReposSuccessState({required this.repos});

  @override
  List<Object?> get props => [repos];
}
