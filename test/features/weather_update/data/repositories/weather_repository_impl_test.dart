import 'package:weatherapp/core/error/exceptions.dart';
import 'package:weatherapp/core/error/failures.dart';
import 'package:weatherapp/core/network/network_info.dart';
import 'package:weatherapp/features/weather_update/data/datasources/weather_remote_data_source.dart';
import 'package:weatherapp/features/weather_update/data/models/weather_model.dart';
import 'package:weatherapp/features/weather_update/data/repositories/weather_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock
    implements WeatherRemoteDataSource {}


class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late WeatherRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('getWeather', () {
    final city = "Berlin";
    final List<WeatherModel> weatherModelList = [
      WeatherModel(
        weather_state_name: "Rainy",
        city: "Berlin",
        applicable_date: "2022-05-21 12:29",
        weather_icon: "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png",
        air_pressure: 1016,
        humidity: 72,
        wind_speed: 26,
        the_temp: 15,
        max_temp: 20,
        min_temp: 13,
      )
    ];
    final List<WeatherModel> weatherList = weatherModelList;

    test(
      'should check if the device is online',
      () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        repository.getWeather(city);
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getCityWeather(city))
              .thenAnswer((_) async => weatherModelList);
          final result = await repository.getWeather(city);
          verify(mockRemoteDataSource.getCityWeather(city));
          expect(result, equals(Right(weatherList)));
        },
      );


      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getCityWeather(city))
              .thenThrow(ServerException());
          final result = await repository.getWeather(city);
          verify(mockRemoteDataSource.getCityWeather(city));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

  });

}
