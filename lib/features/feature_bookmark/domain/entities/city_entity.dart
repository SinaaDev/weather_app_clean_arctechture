import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class CityEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String cityName;

  CityEntity({required this.cityName});

  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}
