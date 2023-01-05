import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/infra/models/user_model.dart';

abstract class GitHubDatasource {
  Future<List<UserModel>> findUsers({
    required String query,
  });
  Future<List<RepoModel>> findRepos({
    required String query,
  });
  Future<UserModel> getUser({
    required String login,
  });
  Future<List<RepoModel>> getReposStarred({
    required String login,
  });
}
