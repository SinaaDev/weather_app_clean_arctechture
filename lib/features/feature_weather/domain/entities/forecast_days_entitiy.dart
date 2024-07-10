import 'package:equatable/equatable.dart';

import '../../data/models/forecast_days_model.dart';

class ForecastDaysEntity extends Equatable {
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? timezoneOffset;
  final Current? current;
  final List<Daily>? daily;
  final List<Alerts>? alerts;

  ForecastDaysEntity(
      {required this.lat,
      required this.lon,
      required this.timezone,
      required this.timezoneOffset,
      required this.current,
      required this.daily,
      required this.alerts});

  @override
  // TODO: implement props
  List<Object?> get props => [
    lat,
    lon,
    timezone,
    timezoneOffset,
    current,
    daily,
    alerts
  ];
}
