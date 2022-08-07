part of 'info_bloc.dart';

abstract class InsightsEvent extends Equatable {
  const InsightsEvent();

  @override
  List<Object> get props => [];
}

class InsightsPageInitializedEvent extends InsightsEvent {}

class ParticularInsightsViewAllPageInitializedEvent extends InsightsEvent {
  final String insightsType;
  final List insightsList;
  ParticularInsightsViewAllPageInitializedEvent({
    this.insightsType,
    this.insightsList,
  });
}
