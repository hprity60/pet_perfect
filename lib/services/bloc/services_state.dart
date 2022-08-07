part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitialState extends ServicesState {}

class ServicesPageServicesLoadingState extends ServicesState {}

class ParticularServiceViewAllLoadingState extends ServicesState {}

class PaginationLoadingState extends ServicesState {}

class ParticularServiceViewAllLoadedState extends ServicesState {
  final List<Service> service;
  final bool listFinished; 
  ParticularServiceViewAllLoadedState(this.service, this.listFinished);
}
