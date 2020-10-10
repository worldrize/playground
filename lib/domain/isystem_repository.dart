// repository
import 'package:flutter/material.dart';

abstract class ISystemRepository {
  void setThemeMode(ThemeMode value);

  ThemeMode getThemeMode();

  void setSystemMode(bool value);

  void setDarkMode(bool value);
}
