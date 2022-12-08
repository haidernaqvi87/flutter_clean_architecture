import 'package:weatherapp/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('isString', () {
    test(
      'should return String when it contains only alphabets',
      () async {
        final str = 'Berlin';
        final result = inputConverter.checkString(str);
        expect(result, Right('Berlin'));
      },
    );

    test(
      'should return a Failure when the string is not alphabets',
      () async {
        final str = '1234';
        final result = inputConverter.checkString(str);
        expect(result, Left(InvalidInputFailure()));
      },
    );


  });
}
