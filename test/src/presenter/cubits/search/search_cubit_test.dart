import 'package:flutter_test/flutter_test.dart';
import 'package:git_search/src/presenter/cubits/search/search_cubit.dart';
import 'package:git_search/src/presenter/cubits/search/search_state.dart';

void main() {
  late SearchCubit searchCubit;

  setUp(() {
    searchCubit = SearchCubit();
  });

  test('should return text typing', () async {
    await searchCubit.handleTextField('fldnascimento');
    expect(
      searchCubit.state,
      const SearchState(valueTextField: 'fldnascimento'),
    );
  });
}
