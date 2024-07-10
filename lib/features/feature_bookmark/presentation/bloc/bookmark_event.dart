part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkEvent {}

// get all city
class GetAllCityEvent extends BookmarkEvent{}

// get city by name
class GetCityByNameEvent extends BookmarkEvent{
  final String cityName;
  GetCityByNameEvent(this.cityName);
}

// save current city weather
class SaveCwEvent extends BookmarkEvent{
  final String cityName;
  SaveCwEvent(this.cityName);
}

// set the saveCityStatus again to initial after adding current city weather
class SaveCityInitialEvent extends BookmarkEvent{}

// delete city
class DeleteCityEvent extends BookmarkEvent{
  final String cityName;
  DeleteCityEvent(this.cityName);
}

