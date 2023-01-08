import '../../../domain/usecases/get_user_usecase.dart';
import '../../my_bloc/cubit.dart';
import 'search_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final GetUserUsecase getUserUsecase;

  UserInfoCubit({
    required this.getUserUsecase,
  }) : super(UserInfoLoadingState());

  Future<void> getUser(String login) async {
    emit(UserInfoLoadingState());
    final result = await getUserUsecase(login: login);
    result.fold(
      (success) => emit(UserInfoSuccessState(user: success)),
      (failure) => emit(UserInfoFailureState(message: failure.message)),
    );
  }
}
