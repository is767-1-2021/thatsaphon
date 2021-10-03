import 'package:flutter/cupertino.dart';

class BottomBarIndex extends ChangeNotifier {
  int bottomBarIndex = 0;
  get getBottomBarIndex => this.bottomBarIndex;

  set setBottomBarIndex(bottomBarIndex) =>
      {this.bottomBarIndex = bottomBarIndex, notifyListeners()};
}
