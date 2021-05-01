import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/atoms/add_button.dart';
import 'package:playground/domain/global_state.dart';
import 'package:playground/pages/counter_page.dart';

class CounterState extends ChangeNotifier {
  CounterState({@required ProviderReference this.ref});

  final ProviderReference ref;

  var count = 0;
  static const colors = [Colors.red, Colors.blue, Colors.green];

  Color get color => colors[count];

  void incrementColor() {
    count = (count + 1) % colors.length;
    print(count);
    notifyListeners();
  }

  void asyncIncrementColor() async {
    await Future.delayed(const Duration(seconds: 1));
    incrementColor();
  }
}

final counterNotifier =
    ChangeNotifierProvider<CounterState>((ref) => CounterState(ref: ref));

class CounterPageWithRiverpods extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // StateNotifier を watch するときは .notifier をつける
    // ChangeNotifier はつけない
    final cn = watch(counterNotifier);
    print(cn.color);

    return Scaffold(
      appBar: AppBar(
        title: Text("counter page with river pods"),
        backgroundColor: cn.color,
      ),
      body: Column(
        children: [
          Center(
            child: Text(cn.count.toString()),
          ),
          RaisedButton(
            onPressed: cn.asyncIncrementColor,
            child: Text('async Increment'),
          ),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: cn.incrementColor,
      ),
    );
  }
}
