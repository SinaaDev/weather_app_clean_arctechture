
import 'package:advanced_flutter/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CityDao {

  @Query('SELECT * FROM CityEntity')
  Future<List<CityEntity>> getAllCity();
  
  @Query("SELECT * FROM CityEntity WHERE cityName = :cityName")
  Future<CityEntity?> findCityByName(String cityName);

  @insert
  Future<void> insertCity(CityEntity city);

  @Query("DELETE FROM CityEntity WHERE cityName = :cityName")
  Future<void> deleteCityByName(String cityName);

}