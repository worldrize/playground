import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/flavors.dart';
import 'package:playground/pages/counter_page.dart';

void runAppWithFlavor() {
  // const にしないとコンパイル時に読み込まれない
  // <https://qiita.com/tetsufe/items/3f2257ac12f812d3f2d6>
  const flavor =
      bool.hasEnvironment('FLAVOR') ? String.fromEnvironment('FLAVOR') : null;
  print(flavor);
  // set flavor enum
  F.fromEnvironment(flavor);

  print("hogeee");

  runApp(ProviderScope(
    child: MaterialApp(
      home: CounterPage(
        flavor: F.appFlavor,
      ),
    ),
  ));
}
