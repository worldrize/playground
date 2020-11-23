import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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

void runAppWithFlavor() async {
  // const にしないとコンパイル時に読み込まれない
  // <https://qiita.com/tetsufe/items/3f2257ac12f812d3f2d6>
  const flavor =
      bool.hasEnvironment('FLAVOR') ? String.fromEnvironment('FLAVOR') : null;
  print(flavor);
  // set flavor enum
  F.fromEnvironment(flavor);

<<<<<<< Updated upstream
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
  runApp(ProviderScope(
    child: Consumer(
      (context, read) => MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: ListView(
              children: pages
                  .map(
                    (e) => GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(e['route']),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 50,
                        child: Text(e['name']),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        routes: Map.fromEntries(
            pages.map((e) => MapEntry(e['route'], e['builder']))),
        themeMode: read(systemProvider).getThemeMode(),
        darkTheme: ThemeData.dark(),
=======
  print("hogeee");

  runApp(ProviderScope(
    child: MaterialApp(
      home: CounterPage(
        flavor: F.appFlavor,
>>>>>>> Stashed changes
      ),
    ),
  ));
}
