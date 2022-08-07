part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class ServicesPageInitializedEvent extends ServicesEvent {
} //First time when gets loaded, it automatically adds this event in the bloc file. (see #1)

class ParticularServiceViewAllPageInitializedEvent extends ServicesEvent {
  final String serviceType;
  final bool sortByRating;
  final int pageNumber;
  // final bool first;

  ParticularServiceViewAllPageInitializedEvent({
    this.sortByRating,
    this.pageNumber,
    this.serviceType,
  });
}

class SearchServiceEvent extends ServicesEvent {
  final String serviceType;
  final int pageNumber;
  final String search;

  SearchServiceEvent(this.search, this.serviceType, {this.pageNumber});
}
