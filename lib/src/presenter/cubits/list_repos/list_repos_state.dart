import 'package:equatable/equatable.dart';

import '../../../domain/entities/repo_entity.dart';

abstract class ListReposState extends Equatable {
  const ListReposState();

  @override
  List<Object?> get props => [];
}

class ListReposLoadingState extends ListReposState {}

class ListReposFailureState extends ListReposState {
  final String message;
  const ListReposFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ListReposSuccessState extends ListReposState {
  final List<RepoEntity> repos;
  const ListReposSuccessState({required this.repos});

  @override
  List<Object?> get props => [repos];
}
