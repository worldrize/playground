import 'package:flutter/material.dart';
import 'package:flutter/src/material/app.dart';
import 'package:playground/domain/isystem_repository.dart';

class SystemRepositoryImpl extends ISystemRepository {
  Map<String, bool> pref = {};

  @override
  ThemeMode getThemeMode() {
    if (pref['system_mode'] ?? false) {
      return ThemeMode.system;
    } else {
      if (pref['dark_mode'] ?? false) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    }
  }

  @override
  void setThemeMode(ThemeMode value) {
    switch (value) {
      case ThemeMode.system:
        {
          pref['system_mode'] = true;
        }
        break;
      case ThemeMode.dark:
        {
          pref['system_mode'] = false;
          pref['dark_mode'] = true;
        }
        break;
      case ThemeMode.light:
        {
          pref['system_mode'] = false;
          pref['dark_mode'] = false;
        }
        break;
    }
  }

  @override
  void setSystemMode(bool value) {
    pref['system_mode'] = value;
  }

  @override
  void setDarkMode(bool value) {
    pref['dark_mode'] = value;
  }
}
