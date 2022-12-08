import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/error/failures.dart';
import 'package:weatherapp/core/error/exceptions.dart';
import 'package:weatherapp/core/network/network_info.dart';
import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';
import 'package:weatherapp/features/weather_update/domain/repositories/weather_repository.dart';
import 'package:weatherapp/features/weather_update/data/datasources/weather_remote_data_source.dart';

/*
Weather Repository Contract Implementation
 */

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<WeatherEntity> >> getWeather(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getCityWeather(city);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      } on DataException {
        return Left(DataFailure());
      }
    } else {
      return Left(InternetFailure());
    }

  }

}
