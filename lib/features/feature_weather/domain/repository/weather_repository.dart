import 'package:advanced_flutter/core/paramas/forecast_params.dart';
import 'package:advanced_flutter/core/resources/data_state.dart';
import 'package:advanced_flutter/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:advanced_flutter/features/feature_weather/domain/entities/current_city_enitity.dart';
import 'package:advanced_flutter/features/feature_weather/domain/entities/forecast_days_entitiy.dart';

abstract class WeatherRepository{
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);

  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(ForecastParams params);

  Future<List<Data>> fetchSuggestsData(cityName);
}