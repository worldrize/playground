import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:playground/flavors.dart';
import 'package:playground/pages/counter_page.dart';
import 'package:playground/pages/counter_page_with_riverpods.dart';
import 'package:playground/pages/iap_page.dart';
import 'package:playground/pages/sign_in_page.dart';
import 'package:playground/pages/system_page.dart';
import 'package:playground/repo/system_repository.dart';
import 'package:playground/service/system_service.dart';
import 'package:playground/util/secrets.dart';

final _systemRepo = SystemRepositoryImpl();
final _systemService = SystemService(_systemRepo);
final systemProvider =
    ChangeNotifierProvider((_) => SystemPageCN(systemService: _systemService));

var pages = [
  {
    'name': 'SignInPage',
    'route': '/signin',
    'builder': (BuildContext context) => new SignInPage(),
  },
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
  {
    'name': 'IapPage',
    'route': '/iap',
    'builder': (BuildContext context) => new IapPage(),
  },
  {
    'name': 'CounterPageWithRiverpods',
    'route': '/counter-river',
    'builder': (BuildContext context) => CounterPageWithRiverpods(),
  },
];

void runAppWithFlavor() async {
  // If you're running an application and need to access the binary messenger before `runApp()` has been called (for example, during plugin initialization), then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // <https://github.com/FirebaseExtended/flutterfire/issues/4631>
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  runZonedGuarded(() async {
    // hook flutter error
    final onError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) async {
      await FirebaseCrashlytics.instance.recordFlutterError(details);
      onError(details);
    };

    // const にしないとコンパイル時に読み込まれない
    // <https://qiita.com/tetsufe/items/3f2257ac12f812d3f2d6>
    const flavor =
        bool.hasEnvironment('FLAVOR') ? String.fromEnvironment('FLAVOR') : null;
    print(flavor);
    // set flavor enum
    F.fromEnvironment(flavor);

    await Secrets()
      ..loadSecrets();

    runApp(
      ProviderScope(
        child: App(),
      ),
    );
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
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
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('${_firebaseAuth.currentUser?.email}'),
            FlatButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              child: Text('crash'),
            ),
            FlatButton(
              onPressed: () {
                throw Exception('fatal error');
              },
              child: Text('crash'),
            ),
            ListView(
              shrinkWrap: true,
              children: pages
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(e['route']),
                        child: Text(
                          e['name'],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
