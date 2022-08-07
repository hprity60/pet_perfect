part of 'search_delegate_bloc.dart';

abstract class SearchDelegateState extends Equatable {
  const SearchDelegateState();

  @override
  List<Object> get props => [];
}

class SearchDelegateInitialState extends SearchDelegateState {}

class SearchDelegateSuggestionsLoadingState extends SearchDelegateState {}

class SearchDelegateSuggestionsLoadedState extends SearchDelegateState {
  final List suggestions;

  SearchDelegateSuggestionsLoadedState({this.suggestions});

  @override
  List<Object> get props => [suggestions];
}

class SearchDelegateSuggestionsFailureState extends SearchDelegateState {
  final String error;

  const SearchDelegateSuggestionsFailureState({this.error});

  List<Object> get props => [error];

  @override
  String toString() => 'SearchDelegateSuggestionsFailure { error: $error }';
}
