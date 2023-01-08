import 'package:result_dart/result_dart.dart';

import '../entities/repo_entity.dart';
import '../errors/errors.dart';
import '../repositories/git_hub_repository.dart';

abstract class GetUserReposUsecase {
  AsyncResult<List<RepoEntity>, Error> call({required String login});
}

class GetUserReposUsecaseImpl implements GetUserReposUsecase {
  final GitHubRepository gitHubRepository;

  const GetUserReposUsecaseImpl({
    required this.gitHubRepository,
  });

  @override
  AsyncResult<List<RepoEntity>, Error> call({required String login}) async {
    if (login.isEmpty) {
      return const Failure(ParamEmpty());
    }

    return gitHubRepository.getUserRepos(login: login);
  }
}
