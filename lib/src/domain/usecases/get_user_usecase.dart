import 'package:result_dart/result_dart.dart';

import '../entities/user_entity.dart';
import '../errors/errors.dart';
import '../repositories/git_hub_repository.dart';

abstract class GetUserUsecase {
  AsyncResult<UserEntity, Error> call({required String login});
}

class GetUserUsecaseImpl implements GetUserUsecase {
  final GitHubRepository gitHubRepository;

  const GetUserUsecaseImpl({
    required this.gitHubRepository,
  });

  @override
  AsyncResult<UserEntity, Error> call({required String login}) async {
    if (login.isEmpty) {
      return const Failure(ParamEmpty());
    }

    return gitHubRepository.getUser(login: login);
  }
}
