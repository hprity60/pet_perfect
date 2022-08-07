import 'dart:convert';
import 'insight.dart';

Insights insightsFromJson(String str) => Insights.fromJson(json.decode(str));

class Insights {
  Insights({
    this.foodsInsights,
    this.healthInsights,
    this.lifestyleInsights,
  });

  List<Insight> foodsInsights;
  List<Insight> lifestyleInsights;
  List<Insight> healthInsights;

  factory Insights.fromJson(Map<String, dynamic> json) => Insights(
        foodsInsights: List<Insight>.from(
            json["foodsInsights"].map((x) => Insight.fromJson(x))),
        healthInsights: List<Insight>.from(
            json["healthInsights"].map((x) => Insight.fromJson(x))),
        lifestyleInsights: List<Insight>.from(
            json["lifestyleInsights"].map((x) => Insight.fromJson(x))),
      );
}
