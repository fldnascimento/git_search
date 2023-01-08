import 'package:result_dart/result_dart.dart';

import '../../domain/entities/repo_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/git_hub_repository.dart';
import '../datasources/git_hub_datasource.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubDatasource datasource;

  const GitHubRepositoryImpl({
    required this.datasource,
  });

  @override
  AsyncResult<List<RepoEntity>, Error> findRepos({
    required String query,
  }) async {
    try {
      final result = await datasource.findRepos(query: query);

      if (result.isEmpty) {
        return const Failure(ReposNotFound());
      }

      return Success(result);
    } on RateLimitExceeded {
      return Failure(RateLimitExceeded());
    } catch (e) {
      return const Failure(Error());
    }
  }

  @override
  AsyncResult<List<UserEntity>, Error> findUsers({
    required String query,
  }) async {
    try {
      final result = await datasource.findUsers(query: query);

      if (result.isEmpty) {
        return const Failure(UsersNotFound());
      }

      return Success(result);
    } on RateLimitExceeded {
      return Failure(RateLimitExceeded());
    } catch (e) {
      return const Failure(Error());
    }
  }

  @override
  AsyncResult<List<RepoEntity>, Error> getReposStarred({
    required String login,
  }) async {
    try {
      final result = await datasource.getReposStarred(login: login);

      if (result.isEmpty) {
        return const Failure(ReposNotFound());
      }

      return Success(result);
    } on RateLimitExceeded {
      return Failure(RateLimitExceeded());
    } catch (e) {
      return const Failure(Error());
    }
  }

  @override
  AsyncResult<UserEntity, Error> getUser({
    required String login,
  }) async {
    try {
      final result = await datasource.getUser(login: login);

      return Success(result);
    } on UserNotFound {
      return Failure(UserNotFound());
    } on RateLimitExceeded {
      return Failure(RateLimitExceeded());
    } catch (e) {
      return const Failure(Error());
    }
  }

  @override
  AsyncResult<List<RepoEntity>, Error> getUserRepos({
    required String login,
  }) async {
    try {
      final result = await datasource.getUserRepos(login: login);

      if (result.isEmpty) {
        return const Failure(ReposNotFound());
      }

      return Success(result);
    } on ReposNotFound {
      return const Failure(ReposNotFound());
    } on RateLimitExceeded {
      return Failure(RateLimitExceeded());
    } catch (e) {
      return const Failure(Error());
    }
  }
}
