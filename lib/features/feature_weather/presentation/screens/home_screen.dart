import 'package:advanced_flutter/core/presentation/widgets/app_background.dart';
import 'package:advanced_flutter/core/presentation/widgets/dot_loading_widget.dart';
import 'package:advanced_flutter/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:advanced_flutter/features/feature_weather/domain/usecase/get_suggestion_city_usecase.dart';
import 'package:advanced_flutter/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/paramas/forecast_params.dart';
import '../../../../locator.dart';
import '../../../feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import '../../data/models/forecast_days_model.dart';
import '../../domain/entities/current_city_enitity.dart';
import '../../domain/entities/forecast_days_entitiy.dart';
import '../bloc/cw_status.dart';
import '../bloc/fw_status.dart';
import '../widgets/bookmark_icon.dart';
import '../widgets/day_weather_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController controller = TextEditingController();

  GetSuggestionCityUseCase getSuggestionCityUseCase = GetSuggestionCityUseCase(locator());

  String cityName = 'Kabul';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: height*0.03),

        // search field
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TypeAheadField(
                  controller: controller,
                    builder: (context, controller, focusNode) {
                      return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          // autofocus: true,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter a City',
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          ),
                        onTapOutside: (_){
                            FocusManager.instance.primaryFocus?.unfocus();
                        },

                      );
                    },
                  hideKeyboardOnDrag: true,
                    itemBuilder: (ctx, Data model){
                      return ListTile(
                        leading: Icon(CupertinoIcons.location_solid,size: 30,),
                        title: Text(model.name!),
                        subtitle: Text('${model.region}, ${model.country!}'),
                      );
                    },
                    onSelected: (Data model){
                      controller.text = model.name!;
                      FocusManager.instance.primaryFocus?.unfocus();
                      BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(model.name!));
                    },
                    suggestionsCallback: (String prefix){
                      return getSuggestionCityUseCase(prefix);
                    }),
              ),
            ),

            BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current){
                  if(previous.cwStatus == current.cwStatus){
                    return false;
                  }
                  return true;
                },
                builder: (context, state){
                  /// show Loading State for Cw
                  if (state.cwStatus is CwLoading) {
                    return const CircularProgressIndicator();
                  }

                  /// show Error State for Cw
                  if (state.cwStatus is CwError) {
                    return IconButton(
                      onPressed: (){
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("please load a city!"),
                        //   behavior: SnackBarBehavior.floating, // Add this line
                        // ));
                      },
                      icon: const Icon(Icons.error,color: Colors.white,size: 35),);
                  }

                  if(state.cwStatus is CwCompleted){
                    final CwCompleted cwComplete = state.cwStatus as CwCompleted;
                    BlocProvider.of<BookmarkBloc>(context).add(GetCityByNameEvent(cwComplete.currentCityEntity.name!));
                    return BookMarkIcon(name: cwComplete.currentCityEntity.name!);
                  }

                  return Container();

                }
            ),]),


        // main UI
        BlocBuilder<HomeBloc, HomeState>(

          buildWhen: (previous, current){
            if(previous.cwStatus == current.cwStatus){
              return false;
            }
            return true;
          },

          builder: (ctx, state) {
            if (state.cwStatus is CwLoading) {
              return const Expanded(child: DotLoadingWidget());
            }

            if (state.cwStatus is CwCompleted) {
              /// cast
              final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
              final CurrentCityEntity currentCityEntity = cwCompleted.currentCityEntity;

              /// create params for api call
              final ForecastParams forecastParams = ForecastParams(currentCityEntity.coord!.lat!, currentCityEntity.coord!.lon!);

              /// start load Fw event
              BlocProvider.of<HomeBloc>(context).add(LoadFwEvent(forecastParams));



              return Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: SizedBox(
                        height: 500,
                        width: width,
                        child: PageView.builder(
                            controller: _pageController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            allowImplicitScrolling: true,
                            itemCount: 2,
                            itemBuilder: (ctx, position) {
                              if (position == 0) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      currentCityEntity.name!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      currentCityEntity
                                          .weather![0].description!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    const SizedBox(height: 50),
                                    AppBackground.setIconForMain(
                                        currentCityEntity
                                            .weather![0].description!),
                                    const SizedBox(height: 20),
                                    Text(
                                      '${currentCityEntity.main!.temp!.round()}\u00B0',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 50),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'max',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '${currentCityEntity.main!.tempMax!.round()}\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          height: 50,
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'min',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '${currentCityEntity.main!.tempMin!.round()}\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Container(
                                  color: Colors.red,
                                );
                              }
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 2,
                        effect: ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          spacing: 5,
                          activeDotColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            if (state.cwStatus is CwError) {
              return const Text('Error');
            }
            return const SizedBox();
          },
        ),
        /// divider
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            color: Colors.white24,
            height: 2,
            width: double.infinity,
          ),
        ),

        /// forecast weather 7 days
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            width: double.infinity,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (BuildContext context, state) {

                    /// show Loading State for Fw
                    if (state.fwStatus is FwLoading) {
                      return const DotLoadingWidget();
                    }

                    /// show Completed State for Fw
                    if (state.fwStatus is FwCompleted) {
                      /// casting
                      final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
                      final ForecastDaysEntity forecastDaysEntity = fwCompleted.forecastDaysEntity;
                      final List<Daily> mainDaily = forecastDaysEntity.daily!;

                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (BuildContext context,
                            int index,) {
                          return DaysWeatherView(
                            daily: mainDaily[index],);
                        },);
                    }

                    /// show Error State for Fw
                    if (state.fwStatus is FwError) {
                      final FwError fwError = state.fwStatus as FwError;
                      return Center(
                        child: Text(fwError.message!),
                      );
                    }

                    /// show Default State for Fw
                    return Container();

                  },
                ),
              ),
            ),
          ),
        ),

        /// divider
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            color: Colors.white24,
            height: 2,
            width: double.infinity,
          ),
        ),
      ],
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
