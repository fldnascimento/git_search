import 'package:equatable/equatable.dart';

import '../../../domain/entities/repo_entity.dart';

abstract class ListReposUserState extends Equatable {
  const ListReposUserState();

  @override
  List<Object?> get props => [];
}

class ListReposUserLoadingState extends ListReposUserState {}

class ListReposUserFailureState extends ListReposUserState {
  final String message;
  const ListReposUserFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ListReposUserSuccessState extends ListReposUserState {
  final List<RepoEntity> repos;
  const ListReposUserSuccessState({required this.repos});

  @override
  List<Object?> get props => [repos];
}
