import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/atoms/add_button.dart';
import 'package:playground/domain/counter_state.dart';
import 'package:playground/flavors.dart';
import 'package:playground/service/counter_service.dart';
import 'package:state_notifier/state_notifier.dart';

// 原則1画面1notifierなので同じファイルに置く?

// <https://qiita.com/karamage/items/8d1352e5a4f1b079210b>
class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(const CounterState(count: 0));

  CounterService get _counterService => read();

  Future increment() async {
    // try-catch
    try {
      final res = await _counterService.increment(state.count);
      print(res);
      state = state.copyWith(count: res);
    } on Exception catch (e) {
      // Errorはログしてrethrow
      print(e);
      rethrow;
    }
  }
}

//final counterRepo = CounterRepositoryImpl();
//final counterService = CounterService(counterRepo);
final counterProvider = StateNotifierProvider((_) => Counter());

class CounterPage extends HookWidget {
  CounterPage({@required this.flavor});
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    final state = useProvider(counterProvider.state);
    final counter = useProvider(counterProvider);
    final loading = useState(false);

    return Scaffold(
      appBar: AppBar(title: Text(F.title)),
      body: Column(
        children: [
          Center(
            child: Text(state.toString()),
          ),
          if (loading.value) CircularProgressIndicator(),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: loading.value
            ? null
            : () async {
                loading.value = true;
                await counter.increment();
                loading.value = false;
              },
      ),
    );
  }
}
