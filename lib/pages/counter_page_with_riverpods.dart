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
    print('color in state notifier: ${state.color}');
    return state.color;
  }

  set color(Color color) {
    state = state.copyWith(color: color);
  }
}

final counterNotifier = ChangeNotifierProvider((ref) {
  print('in change notifier provider create');
  return CounterState(color: ref.watch(globalStateNotifier).color);
});

class CounterState extends ChangeNotifier {
  CounterState({@required Color this.color});

  Color color;
  var count = 0;

  void increment() {
    count += 1;
    print("color in incriment: ${color.toString()}");
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
              backgroundColor: gs.color),
          body: Column(
            children: [
              Center(
                child: Text(cn.count.toString()),
              ),
            ],
          ),
          floatingActionButton: AddButton(onPressed: cn.increment),
        );
      },
    );
  }
}
