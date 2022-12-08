import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends WeatherState {}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final List<WeatherEntity> weather;
  final String inputStr;

  Loaded({required this.weather,required this.inputStr});

  @override
  List<Object> get props => [weather,inputStr];
}

class Error extends WeatherState {
  final String message;
  final String inputStr;

  Error({required this.message, this.inputStr = ""});

  @override
  List<Object> get props => [message,inputStr];
}
