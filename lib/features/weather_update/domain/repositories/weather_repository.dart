import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/error/failures.dart';
import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';

/*
Weather Repository Contract
 */

abstract class WeatherRepository {
  Future<Either<Failure, List<WeatherEntity>>> getWeather(String city);
}
