import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playground/atoms/add_button.dart';
import 'package:playground/domain/counter_state.dart';
import 'package:playground/flavors.dart';
import 'package:playground/repo/counter_repository.dart';
import 'package:playground/service/counter_service.dart';
import 'package:state_notifier/state_notifier.dart';

// 原則1画面1notifierなので同じファイルに置く?

// <https://qiita.com/karamage/items/8d1352e5a4f1b079210b>
class Counter extends StateNotifier<CounterState> {
  Counter(CounterService service)
      : _counterService = service,
        super(const CounterState(count: 0));

  // TODO: Locator mixin
  CounterService _counterService;

  Future<void> increment() async {
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

// TODO: ProviderでProvideしてLocatorMixinで
final counterRepo = CounterRepositoryImpl();
final counterService = CounterService(counterRepo);

final counterProvider = StateNotifierProvider<Counter, CounterState>((_) => Counter(counterService));

class CounterPage extends HookWidget {
  CounterPage({@required this.flavor});

  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    final count = useProvider(counterProvider);
    final vm = useProvider(counterProvider.notifier);
    final loading = useState(false);

    return Scaffold(
      appBar: AppBar(title: Text(F.title)),
      body: Column(
        children: [
          Center(
            child: Text(count.toString()),
          ),
          if (loading.value) CircularProgressIndicator(),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: loading.value
            ? null
            : () async {
                loading.value = true;
                await vm.increment();
                loading.value = false;
              },
      ),
    );
  }
}
