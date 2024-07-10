import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/repository/city_repository.dart';

import '../../../../core/resources/data_state.dart';

class DeleteCityUseCase extends UseCase<DataState<String>, String> {
  final CityRepository cityRepository;

  DeleteCityUseCase(this.cityRepository);

  @override
  Future<DataState<String>> call(String param) {
    return cityRepository.deleteCityByName(param);
  }
}
