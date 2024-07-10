
import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:advanced_flutter/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestionCityUseCase extends UseCase<List<Data>,String>{
  final WeatherRepository weatherRepository;

  GetSuggestionCityUseCase(this.weatherRepository);

  @override
  Future<List<Data>> call(String param) {
    return weatherRepository.fetchSuggestsData(param);
  }

}