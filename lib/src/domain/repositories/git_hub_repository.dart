import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/domain/entities/user_entity.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:result_dart/result_dart.dart';

abstract class GitHubRepository {
  AsyncResult<List<UserEntity>, Error> findUsers({
    required String query,
  });
  AsyncResult<List<RepoEntity>, Error> findRepos({
    required String query,
  });
  AsyncResult<UserEntity, Error> getUser({
    required String login,
  });
  AsyncResult<List<RepoEntity>, Error> getReposStarred({
    required String login,
  });
}
