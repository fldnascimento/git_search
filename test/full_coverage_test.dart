// ignore_for_file: unused_import
import 'package:git_search/src/infra/datasources/git_hub_datasource.dart';
import 'package:git_search/src/infra/repositories/git_hub_repository_impl.dart';
import 'package:git_search/src/infra/models/repo_model.dart';
import 'package:git_search/src/infra/models/user_model.dart';
import 'package:git_search/src/routes.dart';
import 'package:git_search/src/presenter/cubits/list_users/list_users_state.dart';
import 'package:git_search/src/presenter/cubits/list_users/list_users_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_repos_user/list_repos_user_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_repos_user/list_repos_user_state.dart';
import 'package:git_search/src/presenter/cubits/search/search_state.dart';
import 'package:git_search/src/presenter/cubits/search/search_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_repos/list_repos_cubit.dart';
import 'package:git_search/src/presenter/cubits/list_repos/list_repos_state.dart';
import 'package:git_search/src/presenter/cubits/user_info/search_state.dart';
import 'package:git_search/src/presenter/cubits/user_info/search_cubit.dart';
import 'package:git_search/src/presenter/style/sizes.dart';
import 'package:git_search/src/presenter/style/app_theme.dart';
import 'package:git_search/src/presenter/style/components/components.dart';
import 'package:git_search/src/presenter/style/components/git_button.dart';
import 'package:git_search/src/presenter/style/app_colors.dart';
import 'package:git_search/src/presenter/style/spacing.dart';
import 'package:git_search/src/presenter/style/color_schemes.dart';
import 'package:git_search/src/presenter/my_bloc/cubit.dart';
import 'package:git_search/src/presenter/my_bloc/bloc_builder.dart';
import 'package:git_search/src/presenter/pages/list_users_page.dart';
import 'package:git_search/src/presenter/pages/list_repos_page.dart';
import 'package:git_search/src/presenter/pages/splash_page.dart';
import 'package:git_search/src/presenter/pages/list_repos_user_page.dart';
import 'package:git_search/src/presenter/pages/search_page.dart';
import 'package:git_search/src/presenter/pages/user_info_page.dart';
import 'package:git_search/src/presenter/widgets/search_option_widget.dart';
import 'package:git_search/src/presenter/widgets/failure_widget.dart';
import 'package:git_search/src/presenter/widgets/container_search_widget.dart';
import 'package:git_search/src/presenter/widgets/user_detail_widget.dart';
import 'package:git_search/src/presenter/widgets/user_profile_widget.dart';
import 'package:git_search/src/presenter/widgets/progress_indicator_widget.dart';
import 'package:git_search/src/presenter/widgets/list_tile_repos_widget.dart';
import 'package:git_search/src/external/datasources/endpoints/git_hub_endpoints.dart';
import 'package:git_search/src/external/datasources/git_hub_datasource_impl.dart';
import 'package:git_search/src/domain/repositories/git_hub_repository.dart';
import 'package:git_search/src/domain/errors/errors.dart';
import 'package:git_search/src/domain/errors/errors_messages.dart';
import 'package:git_search/src/domain/usecases/find_repos_usecase.dart';
import 'package:git_search/src/domain/usecases/find_users_usecase.dart';
import 'package:git_search/src/domain/usecases/get_repos_starred_usecase.dart';
import 'package:git_search/src/domain/usecases/get_user_repos_usecase.dart';
import 'package:git_search/src/domain/usecases/get_user_usecase.dart';
import 'package:git_search/src/domain/entities/user_entity.dart';
import 'package:git_search/src/domain/entities/repo_entity.dart';
import 'package:git_search/src/injection_container.dart';

void main() => {};
