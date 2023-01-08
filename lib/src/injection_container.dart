import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'domain/repositories/git_hub_repository.dart';
import 'domain/usecases/find_repos_usecase.dart';
import 'domain/usecases/find_users_usecase.dart';
import 'domain/usecases/get_repos_starred_usecase.dart';
import 'domain/usecases/get_user_repos_usecase.dart';
import 'domain/usecases/get_user_usecase.dart';
import 'external/datasources/git_hub_datasource_impl.dart';
import 'infra/datasources/git_hub_datasource.dart';
import 'infra/repositories/git_hub_repository_impl.dart';
import 'presenter/cubits/list_users/list_users_cubit.dart';
import 'presenter/cubits/search/search_cubit.dart';
import 'presenter/cubits/user_info/search_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  // Cubits
  getIt.registerLazySingleton(() => SearchCubit());
  getIt.registerLazySingleton(() => ListUsersCubit(findUsersUsecase: getIt()));
  getIt.registerLazySingleton(() => UserInfoCubit(getUserUsecase: getIt()));

  // Use cases
  getIt.registerLazySingleton<GetUserReposUsecase>(
    () => GetUserReposUsecaseImpl(
      gitHubRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<FindReposUsecase>(
    () => FindReposUsecaseImpl(
      gitHubRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<FindUsersUsecase>(
    () => FindUsersUsecaseImpl(
      gitHubRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetReposStarredUsecase>(
    () => GetReposStarredUsecaseImpl(
      gitHubRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetUserUsecase>(
    () => GetUserUsecaseImpl(
      gitHubRepository: getIt(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<GitHubRepository>(
    () => GitHubRepositoryImpl(
      datasource: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<GitHubDatasource>(
    () => GitHubDatasourceImpl(dio: getIt()),
  );

  // External
  getIt.registerLazySingleton(() => Dio());
}
