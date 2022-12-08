import 'package:bloc/bloc.dart';
import 'package:weatherapp/core/error/failures.dart';
import 'package:weatherapp/core/util/input_converter.dart';
import 'package:weatherapp/features/weather_update/domain/usecases/get_weather_update.dart';
import 'package:weatherapp/features/weather_update/presentation/bloc/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String DATA_FAILURE_MESSAGE = 'No result. Please enter a valid city name';
const String INTERNET_FAILURE_MESSAGE = 'No internet';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The text should only contain alphabets.';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;
  final InputConverter inputConverter;

  WeatherBloc({
    required GetWeatherUseCase current,
    required this.inputConverter,
  })  : assert(current != null),
        assert(inputConverter != null),
        getWeatherUseCase = current,
        super(Empty()){

    //Event Registration
    on<GetWeather>((event, emit) async {
      final inputEither = inputConverter.checkString(event.cityString);

      await inputEither.fold(
            (failure) async {
              emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        },
            (cityStr) async {
              emit(Loading());
              final failureOrWeather = await getWeatherUseCase(Params(city: cityStr));
               failureOrWeather.fold(
                    (failure) => emit(Error(message: _mapFailureToMessage(failure), inputStr: event.cityString)),
                    (weather) => emit(Loaded(weather: weather, inputStr: event.cityString)),
              );
        },
      );
    });
  }

  /*
  return specific error message
   */
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case DataFailure:
        return DATA_FAILURE_MESSAGE;
      case InternetFailure:
        return INTERNET_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

}
