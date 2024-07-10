import 'package:advanced_flutter/features/feature_weather/domain/entities/forecast_days_entitiy.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FwStatus extends Equatable {}

class FwLoading extends FwStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FwCompleted extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;

  FwCompleted(this.forecastDaysEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [forecastDaysEntity];
}

class FwError extends FwStatus {
  final String? message;

  FwError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
