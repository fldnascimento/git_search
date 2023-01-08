import 'package:result_dart/result_dart.dart';

import '../entities/repo_entity.dart';
import '../errors/errors.dart';
import '../repositories/git_hub_repository.dart';

abstract class FindReposUsecase {
  AsyncResult<List<RepoEntity>, Error> call({required String query});
}

class FindReposUsecaseImpl implements FindReposUsecase {
  final GitHubRepository gitHubRepository;

  const FindReposUsecaseImpl({
    required this.gitHubRepository,
  });

  @override
  AsyncResult<List<RepoEntity>, Error> call({required String query}) async {
    if (query.isEmpty) {
      return const Failure(ParamEmpty());
    }

    return gitHubRepository.findRepos(query: query);
  }
}
