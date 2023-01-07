import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_search/src/injection_container.dart';
import 'package:git_search/src/presenter/components/container_search.dart';
import 'package:git_search/src/presenter/cubits/search/search_state.dart';
import 'package:git_search/src/presenter/pages/users_page.dart';

import '../cubits/search/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _textValue = '';

  bool _showContainerSearch = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              TextField(
                onChanged: (value) {
                  _textValue = value;
                  setState(() {
                    if (value.isNotEmpty) {
                      _showContainerSearch = true;
                    } else {
                      _showContainerSearch = false;
                    }
                  });
                },
              ),
            ],
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                getIt<SearchCubit>().findUsers(_textValue);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: _showContainerSearch,
                child: ContainerSearch(query: _textValue),
              ),
              BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {
                  if (state is SearchUsersSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UsersPage(users: state.users),
                      ),
                    );
                  }
                },
                bloc: getIt<SearchCubit>(),
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Visibility(
                    visible: !_showContainerSearch,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Encontre sua coisas.',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Pesquise em todo o Github por Pessoas, Repositórios, e Pull Requests',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
