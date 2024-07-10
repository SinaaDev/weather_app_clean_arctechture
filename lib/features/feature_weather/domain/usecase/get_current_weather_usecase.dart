import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_weather/domain/repository/weather_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../entities/current_city_enitity.dart';

class GetCurrentWeatherUseCase extends UseCase<DataState<CurrentCityEntity>,String>{

  final WeatherRepository _weatherRepository;
  GetCurrentWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(String param) {
    return _weatherRepository.fetchCurrentWeatherData(param);
  }
}