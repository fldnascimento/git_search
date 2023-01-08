import '../../../domain/usecases/find_repos_usecase.dart';
import '../../my_bloc/cubit.dart';
import 'list_repos_state.dart';

class ListReposCubit extends Cubit<ListReposState> {
  final FindReposUsecase findReposUsecase;

  ListReposCubit({
    required this.findReposUsecase,
  }) : super(ListReposLoadingState());

  void findRepos(String query) async {
    final result = await findReposUsecase(query: query);
    result.fold(
      (success) => emit(ListReposSuccessState(repos: success)),
      (failure) => emit(
        ListReposFailureState(message: failure.message),
      ),
    );
  }
}
