import 'package:playground/domain/icounter_repository.dart';

class CounterService {
  ICounterRepository _repo;

  CounterService(ICounterRepository repo) : _repo = repo;

  Future<int> increment(int count) async {
    return _repo.increment(count);
  }
}
