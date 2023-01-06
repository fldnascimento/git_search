import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_search/src/domain/usecases/find_repos_usecase.dart';
import 'package:git_search/src/domain/usecases/find_users_usecase.dart';
import 'package:git_search/src/domain/usecases/get_repos_starred_usecase.dart';
import 'package:git_search/src/domain/usecases/get_user_usecase.dart';
import 'package:git_search/src/presenter/cubits/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FindReposUsecase findReposUsecase;
  final FindUsersUsecase findUsersUsecase;
  final GetReposStarredUsecase getReposStarredUsecase;
  final GetUserUsecase getUserUsecase;

  SearchCubit({
    required this.findReposUsecase,
    required this.findUsersUsecase,
    required this.getReposStarredUsecase,
    required this.getUserUsecase,
  }) : super(SearchInitialState());

  void findUsers(String query) async {
    emit(SearchLoadingState());
    final result = await findUsersUsecase(query: query);
    result.fold(
      (success) => emit(SearchUsersSuccessState(users: success)),
      (failure) => emit(SearchFailureState(errorMessage: failure.toString())),
    );
  }

  void findRepos(String query) async {
    emit(SearchLoadingState());
    final result = await findReposUsecase(query: query);
    result.fold(
      (success) => emit(SearchReposSuccessState(repos: success)),
      (failure) => emit(SearchFailureState(errorMessage: failure.toString())),
    );
  }

  void getReposStarred(String login) async {
    emit(SearchLoadingState());
    final result = await getReposStarredUsecase(login: login);
    result.fold(
      (success) => emit(SearchReposSuccessState(repos: success)),
      (failure) => emit(SearchFailureState(errorMessage: failure.toString())),
    );
  }

  void getUser(String login) async {
    emit(SearchLoadingState());
    final result = await getUserUsecase(login: login);
    result.fold(
      (success) => emit(SearchUserSuccessState(user: success)),
      (failure) => emit(SearchFailureState(errorMessage: failure.toString())),
    );
  }
}
