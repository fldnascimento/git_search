import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../injection_container.dart';
import '../cubits/user_info/search_cubit.dart';
import '../cubits/user_info/search_state.dart';
import '../my_bloc/bloc_builder.dart';
import '../style/breakpoints.dart';
import '../style/components/components.dart';
import '../style/spacing.dart';
import '../widgets/failure_widget.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/user_profile_widget.dart';

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.only(top: Spacing.stackMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<UserInfoCubit, UserInfoState>(
                  bloc: getIt<UserInfoCubit>(),
                  builder: (context, state) {
                    if (state is UserInfoFailureState) {
                      return Expanded(
                        child: FailureWidget(message: state.message),
                      );
                    }

                    if (state is UserInfoLoadingState) {
                      return const Expanded(child: ProgressIndicatorWidget());
                    }

                    if (state is UserInfoSuccessState) {
                      return Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: Breakpoints.mobileMaxWidth,
                          ),
                          padding: const EdgeInsets.only(
                            left: Spacing.inlineMedium,
                            right: Spacing.inlineMedium,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserProfileWidget(user: state.user),
                              const SizedBox(height: Spacing.stackExtraSmall),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GitButton(
                                    label: 'Reposit??rios',
                                    onPressed: () {
                                      context.push(
                                        '/list-repos-user/${state.user.login}/false',
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: Spacing.inlineExtraSmall,
                                  ),
                                  GitButton(
                                    label: 'Estrelou',
                                    onPressed: () {
                                      context.push(
                                        '/list-repos-user/${state.user.login}/true',
                                      );
                                    },
                                  ),
                                ],
                              ),
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
          ),
        ),
      ),
    );
  }
}
