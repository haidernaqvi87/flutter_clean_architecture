import 'package:weatherapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, String> checkString(String str) {
    try {
      RegExp regex = new RegExp('[\u00F0-\u02AFa-zA-Z]');
      if (str.isEmpty || !regex.hasMatch(str)) {
        throw FormatException();
      }
      return Right(str);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}

