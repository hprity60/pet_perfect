import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_delegate_event.dart';
part 'search_delegate_state.dart';

class SearchDelegateBloc
    extends Bloc<SearchDelegateEvent, SearchDelegateState> {
  SearchDelegateBloc() : super(SearchDelegateInitialState());

  @override
  Stream<SearchDelegateState> mapEventToState(
    SearchDelegateEvent event,
  ) async* {
    if (event is SearchDelegateLoadSuggestionsEvent) {
      try {
        print("accesstoken " + event.accessToken);
        yield SearchDelegateSuggestionsLoadingState();
        var list;
        if (event.tag == null && event.accessToken == null)
          list = (await event.loadSuggestions()) as List<String>;
        else {
          if (event.tag != null && event.accessToken == null) {
            list = (await event.loadSuggestions(event.tag)) as List<String>;
          } else if (event.tag == null && event.accessToken != null) {
            list = (await event.loadSuggestions(event.accessToken))
                as List<String>;
          } else
            list = (await event.loadSuggestions(event.tag, event.accessToken))
                as List<String>;
        }
        yield SearchDelegateSuggestionsLoadedState(suggestions: list);
      } catch (error) {
        yield SearchDelegateSuggestionsFailureState(error: error.toString());
      }
    }
  }
}
