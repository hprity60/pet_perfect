import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_app/common/bloc/search_delegate_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  final Bloc<SearchDelegateEvent, SearchDelegateState> searchDelegateBloc;
  List
      completeList; //If you already have complete list to search from, use this to pass it
  bool
      dropdownOnly; //If you do not want to allow custom addition of new item, set this to true
  final loadSuggestions; //Function to return the list of items to be displayed
  final tag; //Additional Optional Parameter can be provided to the function to be called
  final accessToken; //Additional Optional Parameter can be provided to the function to be called
  List list;

//omit loadsuggestion and tag- not needed
//dropdown tag- set to true-
//whenn true cannot add new items for food

  CustomSearchDelegate(
      {this.searchDelegateBloc,
      this.completeList,
      this.dropdownOnly,
      this.loadSuggestions,
      this.tag,
      this.accessToken})
      : super(
          textInputAction: TextInputAction.done,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Timer(Duration(seconds: 0), () {
      if (!dropdownOnly && (list == null || list.isEmpty))
        close(context, query);
      else if (dropdownOnly && (list == null || list.isEmpty))
        Navigator.pop(context, '');
      else if (dropdownOnly && !list.contains(query))
        close(context, query);
      else
        close(context, list[0]);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if ((searchDelegateBloc.state is SearchDelegateInitialState) &&
        (completeList == null || completeList.length == 0)) {
      searchDelegateBloc.add(
        SearchDelegateLoadSuggestionsEvent(
            loadSuggestions: loadSuggestions,
            tag: tag,
            accessToken: accessToken),
      );
    }

    return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
      //cubit: searchDelegateBloc,
      builder: (BuildContext context, SearchDelegateState state) {
        if (state is SearchDelegateSuggestionsLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchDelegateSuggestionsFailureState) {
          return Container();
        } else if (state is SearchDelegateSuggestionsLoadedState) {
          completeList = state.suggestions;
          final suggestionList = query.isEmpty
              ? state.suggestions
              : state.suggestions
                  .where((element) => element
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();

          if (query != '' && dropdownOnly == false) {
            if (suggestionList.length == 0 ||
                (suggestionList.length > 0 &&
                    query.toLowerCase() !=
                        suggestionList[0].toString().toLowerCase()))
              suggestionList.add(query);
          }
          list = suggestionList;

          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                // trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.location_city),
                title: Text(suggestionList[index]),
                onTap: () => close(context, suggestionList[index]),
              );
            },
            itemCount: suggestionList.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
