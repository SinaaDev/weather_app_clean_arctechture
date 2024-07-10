import 'package:advanced_flutter/core/presentation/widgets/app_background.dart';
import 'package:advanced_flutter/core/presentation/widgets/botton_nav.dart';
import 'package:advanced_flutter/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:advanced_flutter/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      BookMarkScreen(
        pageController: pageController,
      )
    ];

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // the page goes behind the bottom nav
      extendBody: true,
      bottomNavigationBar: BottomNav(pageController: pageController),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AppBackground.getBackGroundImage(), fit: BoxFit.cover)),
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}
