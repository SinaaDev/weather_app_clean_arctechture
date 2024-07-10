

import 'package:advanced_flutter/core/usecase/use_case.dart';

import '../../../../core/resources/data_state.dart';
import '../entities/city_entity.dart';
import '../repository/city_repository.dart';

class SaveCityUseCase extends UseCase<DataState<CityEntity>,String>{

  final CityRepository cityRepository;

  SaveCityUseCase(this.cityRepository);

  @override
  Future<DataState<CityEntity>> call(String param) {
    return cityRepository.saveCityToDB(param);
  }


}