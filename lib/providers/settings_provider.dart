import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // Add your settings variables here
  String someSetting = 'default';

  void updateSetting(String value) {
    someSetting = value;
    notifyListeners();
  }
}
