part of 'info_bloc.dart';

abstract class InsightsState extends Equatable {
  const InsightsState();

  @override
  List<Object> get props => [];
}

class InsightsInitialState extends InsightsState {}

class InsightsPageLoadingState extends InsightsState {}

class InsightsPageLoadedState extends InsightsState {
  final Insights insights;
  InsightsPageLoadedState({this.insights});
}


class InsightsLoadingFailedState extends InsightsState {
  final String error;
  InsightsLoadingFailedState({this.error});
}

class ParticularInsightViewAllLoadingState extends InsightsState {}

class ParticularInsightViewAllLoadedState extends InsightsState {
  List<Insight> insights;
  ParticularInsightViewAllLoadedState({this.insights});
}
