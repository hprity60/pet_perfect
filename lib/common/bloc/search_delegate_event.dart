part of 'search_delegate_bloc.dart';

abstract class SearchDelegateEvent extends Equatable {
  const SearchDelegateEvent();

  @override
  List<Object> get props => [];
}

class SearchDelegateLoadSuggestionsEvent extends SearchDelegateEvent {
  final Function loadSuggestions;
  final tag;
  final accessToken;
  SearchDelegateLoadSuggestionsEvent(
      {this.loadSuggestions, this.tag, this.accessToken});
}
