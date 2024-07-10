import 'package:advanced_flutter/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SaveCityStatus extends Equatable{}

class SaveCityInitial extends SaveCityStatus {
  @override
  List<Object?> get props => [];
}

// loading state
class SaveCityLoading extends SaveCityStatus{
  @override
  List<Object?> get props => [];
}

// loaded state
class SaveCityCompleted extends SaveCityStatus{
  final CityEntity city;
  SaveCityCompleted(this.city);

  @override
  List<Object?> get props => [city];
}

// error state
class SaveCityError extends SaveCityStatus{
  final String? message;
  SaveCityError(this.message);

  @override
  List<Object?> get props => [message];
}