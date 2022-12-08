import 'dart:convert';
import 'package:weatherapp/features/weather_update/data/models/weather_model.dart';
import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final weatherModel = WeatherModel(
      weather_state_name: "Partly cloudy",
      city: "Berlin",
      applicable_date: "2022-05-21 12:29",
      weather_icon: "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png",
      air_pressure: 1016,
      humidity: 72,
      wind_speed: 26,
      the_temp: 15,
      max_temp: 13,
      min_temp: 15,
  );

  test(
    'should be a subclass of Weather entity',
    () async {
      // assert
      expect(weatherModel, isA<WeatherEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON text is a text',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('weather.json'));
        final result = WeatherModel.fromJson(jsonMap);
        expect(result, weatherModel);
      },
    );


  });


  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        final result = weatherModel.toJson();
        final expectedMap = {
          'city': 'Berlin',
          'applicable_date': '2022-05-21 12:29',
          'weather_state_name': 'Partly cloudy',
          'weather_icon': 'https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png',
          'wind_speed': 26,
          'humidity': 72,
          'air_pressure': 1016,
          'max_temp': 13,
          'min_temp': 15,
          'the_temp': 15
        };
        expect(result, expectedMap);
      },
    );
  });
}
