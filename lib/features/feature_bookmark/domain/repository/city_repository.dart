
import 'package:advanced_flutter/features/feature_bookmark/domain/entities/city_entity.dart';

import '../../../../core/resources/data_state.dart';

abstract class CityRepository{

  Future<DataState<CityEntity>> saveCityToDB(String cityName);

  Future<DataState<List<CityEntity>>> getAllCityFromDB();

  Future<DataState<CityEntity?>> findCityByName(String cityName);

  Future<DataState<String>> deleteCityByName(String cityName);
}