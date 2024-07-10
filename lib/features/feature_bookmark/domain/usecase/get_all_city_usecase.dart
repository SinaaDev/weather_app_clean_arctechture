import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/repository/city_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../entities/city_entity.dart';

class GetAllCityUseCase extends UseCase<DataState<List<CityEntity>>, NoParams> {
  final CityRepository cityRepository;

  GetAllCityUseCase(this.cityRepository);

  @override
  Future<DataState<List<CityEntity>>> call(NoParams param) {
    return cityRepository.getAllCityFromDB();
  }
}
