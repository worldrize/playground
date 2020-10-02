import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/atoms/add_button.dart';
import 'package:playground/flavors.dart';
import 'package:playground/main.dart';
import 'package:state_notifier/state_notifier.dart';

// 原則1画面1notifierなので同じファイルに置く?

// <https://qiita.com/karamage/items/8d1352e5a4f1b079210b>
class Counter extends StateNotifier<int> {
  Counter() : super(0);

  CounterService _counterService;

  Future increment() async {
    state = await _counterService.increment(state);
  }
}

final counterProvider = StateNotifierProvider((_) => Counter());

class CounterPage extends HookWidget {
  CounterPage({@required this.flavor});
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    final state = useProvider(counterProvider.state);
    final counter = useProvider(counterProvider);

    return Scaffold(
      appBar: AppBar(title: Text(F.title)),
      body: Center(
        child: Text(state.toString()),
      ),
      floatingActionButton: AddButton(
        onPressed: counter.increment,
      ),
    );
  }
}
