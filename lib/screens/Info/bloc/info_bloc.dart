import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';
import 'package:pet_perfect_app/screens/Info/models/insight.dart';
import 'package:pet_perfect_app/screens/Info/models/insights.dart';

part 'info_event.dart';
part 'info_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {

  InsightsBloc() : super(InsightsInitialState()) {
    add(InsightsPageInitializedEvent());
  }

  ApiRepository apiRepository = ApiRepository();
  @override
  Stream<InsightsState> mapEventToState(
    InsightsEvent event,
  ) async* {
    if (event is InsightsPageInitializedEvent) {
      yield InsightsPageLoadingState();
      try {
        Insights insights = await apiRepository.getInsightsLists();
        yield InsightsPageLoadedState(insights: insights);
      } catch (error) {
        yield InsightsLoadingFailedState(error: error);
      }
    }
    if (event is ParticularInsightsViewAllPageInitializedEvent) {
      yield ParticularInsightViewAllLoadingState();
      yield ParticularInsightViewAllLoadedState(insights: event.insightsList);
    }
  }
}
