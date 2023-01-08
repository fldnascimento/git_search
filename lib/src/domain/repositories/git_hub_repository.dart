import 'package:result_dart/result_dart.dart';

import '../entities/repo_entity.dart';
import '../entities/user_entity.dart';
import '../errors/errors.dart';

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
  AsyncResult<List<RepoEntity>, Error> getUserRepos({
    required String login,
  });
}
