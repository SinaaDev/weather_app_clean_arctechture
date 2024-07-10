// database.dart

// required package imports
import 'dart:async';
import 'package:advanced_flutter/features/feature_bookmark/data/data_source/local/city_dao.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CityEntity])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}