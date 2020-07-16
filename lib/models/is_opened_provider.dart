import 'package:flutter/material.dart';

class IsOpenedProvider with ChangeNotifier {
  bool isLeftOpened = false; // 왼쪽 슬라이드 오픈 여부
  bool isRightOpened = false; // 오른쪽 슬라이드 오픈 여부

  bool getIsLeftOpened() => isLeftOpened;
  bool getIsRightOpened() => isRightOpened;

  void setOpenLeftState(bool state) {
    isLeftOpened = state;
    notifyListeners();
  }

  void setOpenRightState(bool state) {
    isRightOpened = state;
    notifyListeners();
  }
}
