import '../models/repo_model.dart';
import '../models/user_model.dart';

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
  Future<List<RepoModel>> getUserRepos({
    required String login,
  });
}
