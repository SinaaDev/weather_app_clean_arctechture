import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;

  const BottomNav({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.transparent,
      elevation: 0.5,
      height: 63,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.home,size: 32,color: Colors.white60,),
            ),
            IconButton(
              onPressed: () {
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.bar_chart,size: 32,color: Colors.white60,),
            ),
          ],
        ),
      ),
    );
  }
}
