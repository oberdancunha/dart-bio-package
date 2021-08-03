import 'bio_result.dart';
import 'failures.dart';

abstract class UseCase<Type, Params> {
  Future<BioResult<Failure, Type>> call(Params params);
}
