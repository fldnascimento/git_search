import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final String valueTextField;
  const SearchState({
    required this.valueTextField,
  });

  @override
  List<Object?> get props => [valueTextField];
}
