import 'package:flutter/material.dart';
import 'package:fluttery_filmy/bloc/bloc_provider.dart';
import 'package:fluttery_filmy/model/enum_util.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc extends BlocBase {
  final _navBarController = BehaviorSubject<BottomNavBarItem>();

  final controller = PageController();

  Observable<BottomNavBarItem> get navBar => _navBarController.stream;
  BottomNavBarItem defaultItem = BottomNavBarItem.NOW_PLAYING;

  void pickItem(int index) {
    switch (index) {
      case 0:
        _navBarController.sink.add(BottomNavBarItem.NOW_PLAYING);
        controller.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
      case 1:
        _navBarController.sink.add(BottomNavBarItem.UPCOMING);
        controller.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
      case 2:
        _navBarController.sink.add(BottomNavBarItem.POPULAR);
        controller.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
    }
  }

  @override
  void dispose() {
    _navBarController.close();
    controller.dispose();
  }
}
