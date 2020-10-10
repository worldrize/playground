import 'package:flutter/material.dart';
import 'package:playground/domain/isystem_repository.dart';

class SystemService {
  ISystemRepository _repo;

  SystemService(ISystemRepository repo) : _repo = repo;

  void setThemeMode(ThemeMode themeMode) {
    _repo.setThemeMode(themeMode);
  }
  ThemeMode getThemeMode() {
    return _repo.getThemeMode();
  }

  void setSystemMode(bool value) {
    _repo.setSystemMode(value);
  }
  void setDarkMode(bool value) {
    _repo.setDarkMode(value);
  }

}
