import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';
import 'package:pet_perfect_app/services/models/service.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_perfect_app/logger.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ApiRepository apiRepository = ApiRepository();
  Geolocator geolocator = Geolocator();
  Position positon;
  List<Service> services;
  int totalCount;
  bool listFinished = false;
  ServicesBloc() : super(ServicesInitialState()) {
    add(ServicesPageInitializedEvent()); //#1 (from events file)
  }

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
    if (event is ServicesPageInitializedEvent) {
      yield ServicesPageServicesLoadingState();
      positon = await geolocator.getCurrentPosition();
      print(positon);

      Map result = await apiRepository.getParticularServiceList(
          "All", LocalDb.userAccessToken,
          longitude: positon.longitude, latitude: positon.latitude);
      // Gets the access token from local repo
      services = result["services"];
      totalCount = result["count"] ?? 0;
      // if(service)
      yield ParticularServiceViewAllLoadedState(
          services.toSet().toList(), listFinished);
    }
    if (event is ParticularServiceViewAllPageInitializedEvent) {
      //When one of the chip is clicked on.

      if (event.pageNumber == 1 || event.pageNumber == null) {
        yield ParticularServiceViewAllLoadingState();

        logger.d(
            "Making request to getParticularService list with pageNumber ${event.pageNumber}, service type: {${event.serviceType}}, and location: latitude}");
        Map result = await apiRepository.getParticularServiceList(
            event.serviceType, LocalDb.userAccessToken,
            sortByRating: event.sortByRating ?? false,
            pageNumber: event.pageNumber,
            latitude: positon.latitude,
            longitude: positon.longitude);
        totalCount = result["count"] ?? 0;
        services = result["services"];
        if (totalCount == 0) listFinished = true;
      } else if (event.pageNumber > 1) {
        if (services.length < totalCount) {
          yield PaginationLoadingState();

          listFinished = false;

          logger.d(
              "Making request to getParticularService list with pageNumber ${event.pageNumber}, service type: {${event.serviceType}}, and location: latitude}");
          Map result = await apiRepository.getParticularServiceList(
              event.serviceType, LocalDb.userAccessToken,
              sortByRating: event.sortByRating,
              pageNumber: event.pageNumber,
              latitude: positon.latitude,
              longitude: positon.longitude);
          services.addAll(result["services"]);
        } else {
          listFinished = true;
        }
      }

      yield ParticularServiceViewAllLoadedState(
          services.toSet().toList(), listFinished);
    }
    if (event is SearchServiceEvent) {
      print("filter services event");
      if (event.pageNumber == 1 || event.pageNumber == null) {
        yield ParticularServiceViewAllLoadingState();

        Map result = await apiRepository.serviceSearch(
            LocalDb.userAccessToken, event.search, event.serviceType,
            pageNumber: event.pageNumber);
        totalCount = result["count"] ?? 0;

        services = result["services"];
        if (totalCount == 0) listFinished = true;

        yield ParticularServiceViewAllLoadedState(
            services.toSet().toList(), listFinished);
      } else if (event.pageNumber > 1) {
        yield PaginationLoadingState();
        if (services.length < totalCount) {
          listFinished = false;

          logger.d(
              "Making request to getParticularService list with pageNumber ${event.pageNumber}, service type: {${event.serviceType}}, and location: latitude}");
          Map result = await apiRepository.serviceSearch(
              LocalDb.userAccessToken, event.search, event.serviceType,
              pageNumber: event.pageNumber);
          services.addAll(result["services"]);
        } else {
          listFinished = true;
        }

        yield ParticularServiceViewAllLoadedState(
            services.toSet().toList(), listFinished);
      }
    }
  }
}
