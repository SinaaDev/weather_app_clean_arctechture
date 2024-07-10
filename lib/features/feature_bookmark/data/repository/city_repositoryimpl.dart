

import 'package:advanced_flutter/core/resources/data_state.dart';
import 'package:advanced_flutter/features/feature_bookmark/data/data_source/local/city_dao.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/repository/city_repository.dart';

class CityRepositoryImpl extends CityRepository{
  
  CityDao cityDao;
  CityRepositoryImpl(this.cityDao);

  @override
  Future<DataState<String>> deleteCityByName(String cityName) async {
    try{
      await cityDao.deleteCityByName(cityName);
      return DataSuccess(cityName);
    }catch(e){
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CityEntity?>> findCityByName(String cityName) async {

    try{
      CityEntity? cityEntity = await cityDao.findCityByName(cityName);
      return DataSuccess(cityEntity);
    }catch(e){
      print(e.toString());
      return DataFailed(e.toString());
    }

  }

  @override
  Future<DataState<List<CityEntity>>> getAllCityFromDB() async {
    try{
      List<CityEntity> cities = await cityDao.getAllCity();
      return DataSuccess(cities);
      
    }catch(e){
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CityEntity>> saveCityToDB(String cityName) async {
   
    try{
      // check city exist or not
      CityEntity? checkCity = await cityDao.findCityByName(cityName);
      if(checkCity != null){
        return DataFailed('$cityName is already exist');
      }
      
      // insert city to database
      CityEntity cityEntity = CityEntity(cityName: cityName);
      await cityDao.insertCity(cityEntity);
      return DataSuccess(cityEntity);
      
    }catch(e){
      print(e.toString());
      return DataFailed(e.toString());
    }
  }
  
}