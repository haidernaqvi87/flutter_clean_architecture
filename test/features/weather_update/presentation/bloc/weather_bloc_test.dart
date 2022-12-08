import 'package:weatherapp/core/error/failures.dart';
import 'package:weatherapp/core/util/input_converter.dart';
import 'package:weatherapp/features/weather_update/data/models/weather_model.dart';
import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';
import 'package:weatherapp/features/weather_update/domain/usecases/get_weather_update.dart';
import 'package:weatherapp/features/weather_update/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetWeatherUseCase extends Mock implements GetWeatherUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late WeatherBloc bloc;
  late MockGetWeatherUseCase mockGetWeatherUseCase;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetWeatherUseCase = MockGetWeatherUseCase();
    mockInputConverter = MockInputConverter();

    bloc = WeatherBloc(
      current: mockGetWeatherUseCase,
      inputConverter: mockInputConverter,
    );
  });


  group('GetWeatherForCity', () {
    final city = 'Berlin';
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

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.checkString(city))
            .thenReturn(Right(city));

    test(
      'should call the InputConverter to validate String',
      () async {
        setUpMockInputConverterSuccess();
        bloc.add(GetWeather(city));
        await untilCalled(mockInputConverter.checkString(city));
        verify(mockInputConverter.checkString(city));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        when(mockInputConverter.checkString("sf4424d"))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        bloc.add(GetWeather(city));
      },
    );

    test(
      'should get data from the use case',
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetWeatherUseCase(Params(city: city)))
            .thenAnswer((_) async => Right(weather));
        bloc.add(GetWeather(city));
        await untilCalled(mockGetWeatherUseCase(Params(city: city)));
        verify(mockGetWeatherUseCase(Params(city: city)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetWeatherUseCase(Params(city: city)))
            .thenAnswer((_) async => Right(weather));
        final expected = [
          Empty(),
          Loading(),
          Loaded(weather: weather,inputStr: city),
        ];
        expectLater(bloc, emitsInOrder(expected));
        bloc.add(GetWeather(city));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetWeatherUseCase(Params(city: city)))
            .thenAnswer((_) async => Left(ServerFailure()));
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        bloc.add(GetWeather(city));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetWeatherUseCase(Params(city: city)))
            .thenAnswer((_) async => Left(InternetFailure()));
        // later
        final expected = [
          Empty(),
          Loading(),
          Error(message: INTERNET_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        bloc.add(GetWeather(city));
      },
    );
  });

}
