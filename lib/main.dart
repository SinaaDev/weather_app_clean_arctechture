import 'package:advanced_flutter/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:advanced_flutter/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:advanced_flutter/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/widgets/main_wrapper.dart';

// before running app the dependency injection must happen
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init locator
  await setup();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => locator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<BookmarkBloc>(),
        ),
      ], child: MainWrapper()),
    ),
  );
}
