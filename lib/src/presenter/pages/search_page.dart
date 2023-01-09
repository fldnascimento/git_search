import 'package:flutter/material.dart';

import '../../injection_container.dart';
import '../cubits/search/search_cubit.dart';
import '../cubits/search/search_state.dart';
import '../my_bloc/bloc_builder.dart';
import '../style/app_theme.dart';
import '../style/breakpoints.dart';
import '../style/sizes.dart';
import '../style/spacing.dart';
import '../widgets/container_search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<SearchCubit>();
    _textController.text = cubit.state.valueTextField;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: Breakpoints.desktopMaxWidth,
                  ),
                  color: context.colorScheme.surface,
                  padding: const EdgeInsets.all(Spacing.insetExtraSmall),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintText: 'Pesquisar no github...',
                      suffix: IconButton(
                        onPressed: () {
                          _textController.text = '';
                          cubit.handleTextField('');
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    onChanged: cubit.handleTextField,
                  ),
                ),
              ],
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.valueTextField.isNotEmpty,
                  replacement: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.insetMedium),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Pesquise no Github',
                              style: context.textTheme.headline2?.copyWith(
                                color: context.colorScheme.onBackground,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: Spacing.stackMedium),
                            Text(
                              'Pesquise em todo o Github por Usuários e Repositórios',
                              style: context.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: Spacing.stackMedium),
                            Icon(
                              Icons.search,
                              size: Sizes.mega,
                              color: context.colorScheme.inverseSurface,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: ContainerSearchWidget(query: state.valueTextField),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
