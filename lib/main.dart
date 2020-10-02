import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/flavors.dart';
import 'package:playground/pages/counter_page.dart';

void main() {
  // const にしないとコンパイル時に読み込まれない
  // <https://qiita.com/tetsufe/items/3f2257ac12f812d3f2d6>
  const flavor =
      bool.hasEnvironment('FLAVOR') ? String.fromEnvironment('FLAVOR') : null;
  print(flavor);
  // set flavor enum
  F.fromEnvironment(flavor);

  runApp(ProviderScope(
    child: MaterialApp(
      home: CounterPage(
        flavor: F.appFlavor,
      ),
    ),
  ));
}

class CounterService {
  ICounterRepository _repo;

  CounterService(ICounterRepository repo) : _repo = repo;

  Future<int> increment(int count) async {
    return _repo.increment(count);
  }
}
