import '../../my_bloc/cubit.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
      : super(const SearchState(
          valueTextField: '',
        ));

  handleTextField(String value) {
    emit(SearchState(valueTextField: value));
  }
}
