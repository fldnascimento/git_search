import 'package:result_dart/result_dart.dart';

import '../entities/repo_entity.dart';
import '../errors/errors.dart';
import '../repositories/git_hub_repository.dart';

abstract class GetReposStarredUsecase {
  AsyncResult<List<RepoEntity>, Error> call({required String login});
}

class GetReposStarredUsecaseImpl implements GetReposStarredUsecase {
  final GitHubRepository gitHubRepository;

  const GetReposStarredUsecaseImpl({
    required this.gitHubRepository,
  });

  @override
  AsyncResult<List<RepoEntity>, Error> call({required String login}) async {
    if (login.isEmpty) {
      return const Failure(ParamEmpty());
    }

    return gitHubRepository.getReposStarred(login: login);
  }
}
