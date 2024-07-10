import 'package:advanced_flutter/features/feature_weather/domain/entities/current_city_enitity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CwStatus {}

class CwLoading extends CwStatus {}

class CwCompleted extends CwStatus {
  final CurrentCityEntity currentCityEntity;

  CwCompleted(this.currentCityEntity);
}

class CwError extends CwStatus {
  final String message;

  CwError(this.message);
}
