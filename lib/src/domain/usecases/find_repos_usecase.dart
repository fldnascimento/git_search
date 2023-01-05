import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';
import 'package:result_dart/result_dart.dart';

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
      return Failure(ParamEmpty());
    }
    
    return gitHubRepository.findRepos(query: query);
  }
}
