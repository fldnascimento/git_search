import 'package:flutter/material.dart';

import '../components/container_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _textValue = '';

  bool _showContainerSearch = false;
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Buscar no github...',
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _textEditingController.text = '';
                      _showContainerSearch = false;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: _showContainerSearch,
            child: ContainerSearch(query: _textValue),
          ),
          Visibility(
            visible: !_showContainerSearch,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'Pesquise no Github.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pesquise em todo o Github por Usuários e Repositórios',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
