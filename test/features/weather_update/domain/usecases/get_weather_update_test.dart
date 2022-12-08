import 'package:weatherapp/features/weather_update/data/models/weather_model.dart';
import 'package:weatherapp/features/weather_update/domain/repositories/weather_repository.dart';
import 'package:weatherapp/features/weather_update/domain/usecases/get_weather_update.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockWeatherRepository extends Mock
    implements WeatherRepository {}

void main() {
  late GetWeatherUseCase usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherUseCase(mockWeatherRepository);
  });

  final city = "Berlin";
  final List<WeatherModel> weather = [
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

  test(
    'should get Weather for the city from the repository',
    () async {
      when(mockWeatherRepository.getWeather(city))
          .thenAnswer((_) async => Right(weather));
      final result = await usecase(Params(city: city));

      expect(result, Right(weather));
      verify(mockWeatherRepository.getWeather(city));
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
