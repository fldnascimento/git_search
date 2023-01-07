import 'package:flutter/material.dart';
import 'package:git_search/src/domain/entities/user_entity.dart';
import 'package:git_search/src/injection_container.dart';
import 'package:git_search/src/presenter/cubits/user_info/search_cubit.dart';

import '../cubits/user_info/search_state.dart';
import '../my_bloc/bloc_builder.dart';

class UserInfoPage extends StatefulWidget {
  final String login;

  const UserInfoPage({
    super.key,
    required this.login,
  });

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    super.initState();
    getIt<UserInfoCubit>().getUser(widget.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<UserInfoCubit, UserInfoState>(
            bloc: getIt<UserInfoCubit>(),
            builder: (context, state) {
              if (state is UserInfoLoadingState) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is UserInfoSuccessState) {
                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(state.user.avatarUrl),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user.name ?? state.user.login,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    state.user.login,
                                    style: const TextStyle(
                                      color: Color(0xFF777777),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Visibility(
                          visible: state.user.bio != null,
                          child: Column(
                            children: [
                              Text(
                                state.user.bio ?? '',
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.user.company != null,
                          child: UserDetail(
                            icon: Icons.apartment,
                            label: state.user.company ?? '',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Visibility(
                          visible: state.user.location != null,
                          child: UserDetail(
                            icon: Icons.pin_drop,
                            label: state.user.location ?? '',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Visibility(
                          visible: visibilityFollowersAndFollowing(state.user),
                          child: UserDetail(
                            icon: Icons.person,
                            label: followersAndFollowing(state.user),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => {},
                                label: const Text('Repos'),
                                icon: const Icon(Icons.book),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => {},
                                label: const Text('Starred'),
                                icon: const Icon(Icons.star),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  bool visibilityFollowersAndFollowing(UserEntity user) {
    return user.following != null || user.followers != null;
  }

  String followersAndFollowing(UserEntity user) {
    if (user.following != null || user.followers != null) {
      return '${user.followers} seguidores ▪️ ${user.following} seguindo';
    }

    return '';
  }
}

class UserDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  const UserDetail({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF444444),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
