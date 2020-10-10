import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/app.dart';
import 'package:playground/flavors.dart';
import 'package:playground/service/system_service.dart';
import 'package:settings_ui/settings_ui.dart';

class SystemPageCN extends ChangeNotifier {
  SystemPageCN({@required SystemService systemService})
      : _systemService = systemService;
  final SystemService _systemService;

  bool isSystemMode() {
    return _systemService.getThemeMode() == ThemeMode.system;
  }

  bool isDarkMode() {
    return _systemService.getThemeMode() == ThemeMode.dark;
  }

  ThemeMode getThemeMode() {
    print('get theme mode');
    return _systemService.getThemeMode();
  }

  void setSystemMode(bool value) {
    _systemService.setSystemMode(value);
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _systemService.setDarkMode(value);
    notifyListeners();
  }
}

class SystemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer((BuildContext context, read) {
      final sp = read(systemProvider);
      return Scaffold(
        appBar: AppBar(title: Text(F.title)),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'system mode',
              tiles: [
                SettingsTile.switchTile(
                  switchValue: sp.isSystemMode(),
                  title: '端末の設定に従う',
                  onToggle: (v) {
                    print('system: $v');
                    sp.setSystemMode(v);
                  },
                ),
                if (!sp.isSystemMode())
                  SettingsTile.switchTile(
                    switchValue: sp.isDarkMode(),
                    title: 'dark mode',
                    onToggle: (v) {
                      print('dark: $v');
                      sp.setDarkMode(v);
                    },
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
