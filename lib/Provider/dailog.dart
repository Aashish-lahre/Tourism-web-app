import 'package:flutter/material.dart';

class DialogProvider with ChangeNotifier {
  bool _isImageCarouselDailogShowing = false;

  bool get isImageCarouselDialogShowing => _isImageCarouselDailogShowing;

  void updateImageCarouselDialogShowingStatus() async {
    _isImageCarouselDailogShowing = !_isImageCarouselDailogShowing;
    await Future.delayed(Duration(milliseconds: 400));
    notifyListeners();
  }
}
