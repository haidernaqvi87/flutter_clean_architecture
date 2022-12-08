import 'dart:convert';

import 'package:weatherapp/core/constants.dart';
import 'package:weatherapp/core/error/exceptions.dart';
import 'package:weatherapp/features/weather_update/data/datasources/weather_remote_data_source.dart';
import 'package:weatherapp/features/weather_update/data/models/weather_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late WeatherRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(
        Uri.parse(FORECAST_API_URL+'?access_key='+FORECAST_API_KEY+'&query=Berlin')
        , headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('weather.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(
        Uri.parse(FORECAST_API_URL+'?access_key='+FORECAST_API_KEY+'&query=Berlin'),
        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getWeatherUpdate', () {
    final city = "Berlin";
    final weatherModel =
        WeatherModel.fromJson(json.decode(fixture('weather.json')));

    test(
      '''should perform a GET request on a URL with city
       being the endpoint and with application/json header''',
      () async {
        setUpMockHttpClientSuccess200();
        dataSource.getCityWeather(city);
        verify(mockHttpClient.get(Uri.parse(
            FORECAST_API_URL+'?access_key='+FORECAST_API_KEY+'&query=$city'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return WeatherModel when the response code is 200 (success)',
      () async {
        setUpMockHttpClientSuccess200();
        final result = await dataSource.getCityWeather(city);
        expect(result, equals(weatherModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        setUpMockHttpClientFailure404();
        final call = dataSource.getCityWeather;
        expect(() => call(city), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

}
