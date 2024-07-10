import 'package:advanced_flutter/core/paramas/forecast_params.dart';
import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_weather/domain/entities/forecast_days_entitiy.dart';
import 'package:advanced_flutter/features/feature_weather/domain/repository/weather_repository.dart';
import '../../../../core/resources/data_state.dart';

class GetForecastWeatherUseCase extends UseCase<DataState<ForecastDaysEntity>,ForecastParams>{

  final WeatherRepository _weatherRepository;
  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams param) {
    return _weatherRepository.fetchForecastWeatherData(param);
  }
}