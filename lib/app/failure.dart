abstract class Failure{
  final String message;
  Failure({required this.message});
}

class LocalStorageFailure extends Failure{
  LocalStorageFailure({required super.message});
}

class UnknownFailure extends Failure{
  UnknownFailure({required super.message});
}