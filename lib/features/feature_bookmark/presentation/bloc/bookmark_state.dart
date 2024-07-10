part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetAllCityStatus getAllCityStatus;
  final DeleteCityStatus deleteCityStatus;
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;

  BookmarkState({
    required this.getCityStatus,
    required this.saveCityStatus,
    required this.getAllCityStatus,
    required this.deleteCityStatus,
  });

  BookmarkState copyWith({
    GetCityStatus? newGetCityStatus,
    SaveCityStatus? newSaveCityStatus,
    DeleteCityStatus? newDeleteCityStatus,
    GetAllCityStatus? newGetAllCityStatus,
  }) {
    return BookmarkState(
      getCityStatus: newGetCityStatus ?? getCityStatus,
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
      getAllCityStatus: newGetAllCityStatus ?? getAllCityStatus,
      deleteCityStatus: newDeleteCityStatus ?? deleteCityStatus,
    );
  }

  @override
  List<Object?> get props =>
      [getCityStatus, saveCityStatus, deleteCityStatus, getAllCityStatus];
}
