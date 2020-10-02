import 'package:playground/domain/icounter_repository.dart';

class CounterRepositoryImpl extends ICounterRepository {
  @override
  Future<int> increment(int count) async {
    await Future.delayed(Duration(milliseconds: 300));
    return count + 1;
  }
}
