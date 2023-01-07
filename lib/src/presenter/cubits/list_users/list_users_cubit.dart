import '../../../domain/usecases/find_users_usecase.dart';
import '../../my_bloc/cubit.dart';
import 'list_users_state.dart';

class ListUsersCubit extends Cubit<ListUsersState> {
  final FindUsersUsecase findUsersUsecase;

  ListUsersCubit({
    required this.findUsersUsecase,
  }) : super(ListUsersInitialState());

  void findUsers(String query) async {
    emit(ListUsersLoadingState());
    final result = await findUsersUsecase(query: query);
    result.fold(
      (success) => emit(ListUsersSuccessState(users: success)),
      (failure) =>
          emit(ListUsersFailureState(errorMessage: failure.errorMessage ?? '')),
    );
  }
}
