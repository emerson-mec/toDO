import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
 
  bool tema = false;
 
  AppSettings() {
    _startSettings();
  }
 
  _startSettings() async {
    await _startPreferences();
    await _readTema();
  }
 
  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
 
  _readTema() {
    final boolTema =_prefs.getBool('themeAppBar') ?? false;
    tema = boolTema;
    notifyListeners();
  }
 
  
}
