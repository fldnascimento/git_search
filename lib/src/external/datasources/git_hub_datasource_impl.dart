import 'package:dio/dio.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/external/datasources/endpoints/git_hub_endpoints.dart';
import 'package:git_search/src/infra/datasources/git_hub_datasource.dart';
import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/infra/models/user_model.dart';

class GitHubDatasourceImpl implements GitHubDatasource {
  final Dio dio;

  const GitHubDatasourceImpl({
    required this.dio,
  });

  @override
  Future<List<RepoModel>> findRepos({
    required String query,
  }) async {
    try {
      final url = GitHubEndpoints.findRepos(query);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final repos = (response.data['items'] as List)
            .map((repo) => RepoModel.fromMap(repo))
            .toList();

        return repos;
      } else if (response.statusCode == 403) {
        throw RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutConnection();
      }
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> findUsers({
    required String query,
  }) async {
    try {
      final url = GitHubEndpoints.findUsers(query);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final users = (response.data['items'] as List)
            .map((user) => UserModel.fromMap(user))
            .toList();

        return users;
      } else if (response.statusCode == 403) {
        throw RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutConnection();
      }
      rethrow;
    }
  }

  @override
  Future<List<RepoModel>> getReposStarred({
    required String login,
  }) async {
    try {
      final url = GitHubEndpoints.getReposStarred(login);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final reposStarred = (response.data as List)
            .map((repo) => RepoModel.fromMap(repo))
            .toList();

        return reposStarred;
      } else if (response.statusCode == 403) {
        throw RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutConnection();
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser({
    required String login,
  }) async {
    try {
      final url = GitHubEndpoints.getReposStarred(login);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final user = UserModel.fromMap(response.data as Map<String, dynamic>);

        return user;
      } else if (response.statusCode == 404) {
        throw UserNotFound();
      } else if (response.statusCode == 403) {
        throw RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutConnection();
      }
      rethrow;
    }
  }
}
