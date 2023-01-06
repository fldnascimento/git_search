import 'package:result_dart/result_dart.dart';

import '../entities/user_entity.dart';
import '../errors/errors.dart';
import '../repositories/git_hub_repository.dart';

abstract class FindUsersUsecase {
  AsyncResult<List<UserEntity>, Error> call({required String query});
}

class FindUsersUsecaseImpl implements FindUsersUsecase {
  final GitHubRepository gitHubRepository;

  const FindUsersUsecaseImpl({
    required this.gitHubRepository,
  });

  @override
  AsyncResult<List<UserEntity>, Error> call({required String query}) async {
    if (query.isEmpty) {
      return Failure(ParamEmpty());
    }

    return gitHubRepository.findUsers(query: query);
  }
}
