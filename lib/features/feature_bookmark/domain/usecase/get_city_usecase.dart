
import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/repository/city_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../entities/city_entity.dart';

class GetCityUseCase extends UseCase<DataState<CityEntity?>,String>{
  final CityRepository cityRepository;

  GetCityUseCase(this.cityRepository);

  @override
  Future<DataState<CityEntity?>> call(String param) {
    return cityRepository.findCityByName(param);
  }

}