import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/atoms/add_button.dart';
import 'package:playground/domain/global_state.dart';

final globalStateNotifier = StateNotifierProvider<Global>((_) => Global());

class Global extends StateNotifier<GlobalState> {
  Global() : super(const GlobalState(color: Colors.red));

  get color {
    print('read color in state notifier: ${state.color}');
    return state.color;
  }

  set color(Color color) {
    state = state.copyWith(color: color);
  }
}

// 初めてwatch(readも?)されたときにCounterStateが作られるので
// 一気に複数のProviderがロードされて重いとかがない
final counterNotifier = ChangeNotifierProvider((ref) {
  print('in change notifier provider create');
  return CounterState(ref: ref);
});

class CounterState extends ChangeNotifier {
  CounterState({@required ProviderReference this.ref});

  final ProviderReference ref;

  var count = 0;

  void increment() {
    count += 1;
    final gs = ref.watch(globalStateNotifier);
    print("color in incriment: ${gs.color.toString()}");
    notifyListeners();
  }

  void asyncIncrement() async {
    print('start async');
    final gs = ref.watch(globalStateNotifier);
    print("color in async incriment: ${gs.color.toString()}");
    await Future.delayed(const Duration(seconds: 1));
    print('end async');
    count += 1;
    notifyListeners();
  }
}

class CounterPageWithRiverpods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final gs = watch(globalStateNotifier);
        print('called consumer builder');
        gs.color = [Colors.red, Colors.blue, Colors.green][Random().nextInt(3)];
        final cn = watch(counterNotifier);
        return Scaffold(
          appBar: AppBar(
              title: Text("counter page with riverpods"),
              backgroundColor: context.read(globalStateNotifier).color),
          body: Column(
            children: [
              Center(
                child: Text(cn.count.toString()),
              ),
              RaisedButton(
                onPressed: cn.asyncIncrement,
                child: Text('async Incriment'),
              ),
            ],
          ),
          floatingActionButton: AddButton(onPressed: () {
            cn.increment();
            print(
                'on pressed color: ${context.read(globalStateNotifier).color}');
          }),
        );
      },
    );
  }
}
