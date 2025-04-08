import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/screens/about_me/second_section.dart';

import 'about_me/first_section.dart';
import 'about_me/third_section.dart';

class AboutMeScreen extends StatefulWidget {
  @override
  _AboutMeScreenState createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _scrolling = false;
  Duration duration = Duration(milliseconds: 500);

  void _onScroll(PointerScrollEvent event) async {
    if (_scrolling) return;
    _scrolling = true;

    if (event.scrollDelta.dy > 0 && _currentPage < 2) {
      _currentPage++;
    } else if (event.scrollDelta.dy < 0 && _currentPage > 0) {
      _currentPage--;
    }

    await _pageController.animateToPage(
      _currentPage,
      duration: duration,
      curve: Curves.easeInOut,
    );

    Future.delayed(duration, () {
      _scrolling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _onScroll(event);
        }
      },
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: [
          FirstSection(),
          SecondSection(),
          ThirdSection(),
        ],
      ),
    );
  }
}
