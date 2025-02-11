import 'package:advanced_flutter/core/paramas/forecast_params.dart';
import 'package:advanced_flutter/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/get_current_weather_usecase.dart';
import '../../domain/usecase/get_forecast_weather_usecase.dart';
import 'fw_status.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;

  // the first state when the app opens is loading
  HomeBloc(this.getCurrentWeatherUseCase, this.getForecastWeatherUseCase) : super(HomeState(cwStatus: CwLoading(),fwStatus: FwLoading())) {

    on<LoadCwEvent>((event, emit) async {

      emit(state.copyWith(newCwStatus: CwLoading()));

      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if(dataState is DataSuccess){
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }

    });

    /// load 7 days Forecast weather for city Event
    on<LoadFwEvent>((event, emit) async {

      /// emit State to Loading for just Fw
      emit(state.copyWith(newFwStatus: FwLoading()));

      DataState dataState = await getForecastWeatherUseCase(event.forecastParams);

      /// emit State to Completed for just Fw
      if(dataState is DataSuccess){
        emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));
      }

      /// emit State to Error for just Fw
      if(dataState is DataFailed){
        emit(state.copyWith(newFwStatus: FwError(dataState.error)));
      }

    });
  }
}
