import 'package:dio/dio.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/git_hub_datasource.dart';
import '../../infra/models/repo_model.dart';
import '../../infra/models/user_model.dart';
import 'endpoints/git_hub_endpoints.dart';

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
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw const TimeoutConnection();
      }
      if (e.response?.statusCode == 403) {
        throw const RateLimitExceeded();
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
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw const TimeoutConnection();
      }
      if (e.response?.statusCode == 403) {
        throw const RateLimitExceeded();
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
        throw const RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw const TimeoutConnection();
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser({
    required String login,
  }) async {
    try {
      final url = GitHubEndpoints.getUser(login);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final user = UserModel.fromMap(response.data as Map<String, dynamic>);

        return user;
      } else if (response.statusCode == 404) {
        throw const UserNotFound();
      } else if (response.statusCode == 403) {
        throw const RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw const TimeoutConnection();
      }
      rethrow;
    }
  }

  @override
  Future<List<RepoModel>> getUserRepos({
    required String login,
  }) async {
    try {
      final url = GitHubEndpoints.getUserRepos(login);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final reposStarred = (response.data as List)
            .map((repo) => RepoModel.fromMap(repo))
            .toList();

        return reposStarred;
      } else if (response.statusCode == 404) {
        throw const ReposNotFound();
      } else if (response.statusCode == 403) {
        throw const RateLimitExceeded();
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw const TimeoutConnection();
      }
      rethrow;
    }
  }
}
