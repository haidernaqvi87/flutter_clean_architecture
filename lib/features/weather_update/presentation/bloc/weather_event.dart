import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetWeather extends WeatherEvent {
  final String cityString;

  GetWeather(this.cityString);

  @override
  List<Object> get props => [cityString];
}