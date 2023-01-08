import 'package:git_search/src/domain/usecases/get_repos_starred_usecase.dart';
import 'package:git_search/src/domain/usecases/get_user_repos_usecase.dart';

import '../../my_bloc/cubit.dart';
import 'list_repos_user_state.dart';

class ListReposUserCubit extends Cubit<ListReposUserState> {
  final GetUserReposUsecase getUserReposUsecase;
  final GetReposStarredUsecase getReposStarredUsecase;

  ListReposUserCubit({
    required this.getUserReposUsecase,
    required this.getReposStarredUsecase,
  }) : super(ListReposUserInitialState());

  void getUserRepos(String login) async {
    emit(ListReposUserLoadingState());
    final result = await getUserReposUsecase(login: login);
    result.fold(
      (success) => emit(ListReposUserSuccessState(repos: success)),
      (failure) => emit(
        ListReposUserFailureState(errorMessage: failure.errorMessage ?? ''),
      ),
    );
  }

  void getReposStarred(String login) async {
    emit(ListReposUserLoadingState());
    final result = await getReposStarredUsecase(login: login);
    result.fold(
      (success) => emit(ListReposUserSuccessState(repos: success)),
      (failure) => emit(
        ListReposUserFailureState(errorMessage: failure.errorMessage ?? ''),
      ),
    );
  }
}
