import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/flavors.dart';
import 'package:playground/pages/counter_page.dart';
import 'package:playground/pages/system_page.dart';
import 'package:playground/repo/system_repository.dart';
import 'package:playground/service/system_service.dart';

final _systemRepo = SystemRepositoryImpl();
final _systemService = SystemService(_systemRepo);
final systemProvider =
    ChangeNotifierProvider((_) => SystemPageCN(systemService: _systemService));

var pages = [
  {
    'name': 'CounterPage',
    'route': '/counter',
    'builder': (BuildContext context) => new CounterPage(flavor: F.appFlavor),
  },
  {
    'name': 'SystemPage',
    'route': '/system',
    'builder': (BuildContext context) => new SystemPage(),
  },
];

void runAppWithFlavor() async {
  // const にしないとコンパイル時に読み込まれない
  // <https://qiita.com/tetsufe/items/3f2257ac12f812d3f2d6>
  const flavor =
      bool.hasEnvironment('FLAVOR') ? String.fromEnvironment('FLAVOR') : null;
  print(flavor);
  // set flavor enum
  F.fromEnvironment(flavor);

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoutesList(),
      routes:
          Map.fromEntries(pages.map((e) => MapEntry(e['route'], e['builder']))),
      themeMode: useProvider(systemProvider).getThemeMode(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class RoutesList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: pages
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () => Navigator.of(context).pushNamed(e['route']),
                  child: Text(
                    e['name'],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
