abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class FileSystemFailure extends Failure{
  FileSystemFailure({required String errorMessage})
  : super(errorMessage: errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
