import 'package:advanced_flutter/core/usecase/use_case.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/usecase/delete_city_usecase.dart';
import 'package:advanced_flutter/features/feature_bookmark/domain/usecase/get_all_city_usecase.dart';
import 'package:advanced_flutter/features/feature_bookmark/presentation/bloc/get_city_status.dart';
import 'package:advanced_flutter/features/feature_bookmark/presentation/bloc/save_city_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/get_city_usecase.dart';
import '../../domain/usecase/save_city_usecase.dart';
import 'delete_city_status.dart';
import 'get_all_city_status.dart';

part 'bookmark_event.dart';

part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetCityUseCase getCityUseCase;
  SaveCityUseCase saveCityUseCase;
  GetAllCityUseCase getAllCityUseCase;
  DeleteCityUseCase deleteCityUseCase;

  BookmarkBloc(
    this.getCityUseCase,
    this.saveCityUseCase,
    this.deleteCityUseCase,
    this.getAllCityUseCase,
  ) : super(BookmarkState(
          getCityStatus: GetCityLoading(),
          saveCityStatus: SaveCityInitial(),
          getAllCityStatus: GetAllCityLoading(),
          deleteCityStatus: DeleteCityInitial(),
        )) {
    /// get city by name from DB event
    on<GetCityByNameEvent>((event, emit) async {
      // emit loading state
      emit(state.copyWith(newGetCityStatus: GetCityLoading()));

      // fetch the data from database
      DataState dataState = await getCityUseCase(event.cityName);

      // emit complete state
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetCityStatus: GetCityCompleted(dataState.data)));
      }

      // emit error state
      if (dataState is DataFailed) {
        emit(state.copyWith(newGetCityStatus: GetCityError(dataState.error)));
      }
    });

    /// save city into DB event
    on<SaveCwEvent>((event, emit) async {
      // emit loading state
      emit(state.copyWith(newSaveCityStatus: SaveCityLoading()));

      // saving city into DB
      DataState dataState = await saveCityUseCase(event.cityName);

      // emit complete state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newSaveCityStatus: SaveCityCompleted(dataState.data)));
      }

      // emit error state
      if (dataState is DataFailed) {
        emit(state.copyWith(newSaveCityStatus: SaveCityError(dataState.error)));
      }
    });

    /// set the saveCityState to initial state otherwise the bookmark will be fill on all cities
    on<SaveCityInitialEvent>((event, emit) {
      emit(state.copyWith(newSaveCityStatus: SaveCityInitial()));
    });


    /// get all cities from DB
    on<GetAllCityEvent>((event, emit) async {

      /// emit Loading state
      emit(state.copyWith(newGetAllCityStatus: GetAllCityLoading()));

      DataState dataState = await getAllCityUseCase(NoParams());

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newGetAllCityStatus: GetAllCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newGetAllCityStatus: GetAllCityError(dataState.error)));
      }
    });

    /// City Delete Event
    on<DeleteCityEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newDeleteCityStatus: DeleteCityLoading()));

      DataState dataState = await deleteCityUseCase(event.cityName);

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newDeleteCityStatus: DeleteCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newDeleteCityStatus: DeleteCityError(dataState.error)));
      }
    });
  }
}
