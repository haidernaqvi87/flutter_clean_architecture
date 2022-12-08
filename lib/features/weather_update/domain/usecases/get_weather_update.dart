import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/core/error/failures.dart';
import 'package:weatherapp/core/usecases/usecase.dart';
import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';
import 'package:weatherapp/features/weather_update/domain/repositories/weather_repository.dart';

class GetWeatherUseCase implements UseCase<List<WeatherEntity>, Params> {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  @override
  Future<Either<Failure, List<WeatherEntity>>> call(Params params) async {
    return await repository.getWeather(params.city);
  }
}

class Params extends Equatable {
  final String city;

  Params({required this.city});

  @override
  List<Object> get props => [city];
}
