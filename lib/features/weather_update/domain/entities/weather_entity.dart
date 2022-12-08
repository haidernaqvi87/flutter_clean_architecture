import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String city;
  final String weather_state_name;
  final String applicable_date;
  final String weather_icon;
  final int wind_speed;
  final int humidity;
  final int air_pressure;
  final int max_temp;
  final int min_temp;
  final int the_temp;

  WeatherEntity({
    required this.city,
    required this.weather_state_name,
    required this.applicable_date,
    required this.weather_icon,
    required this.wind_speed,
    required this.humidity,
    required this.air_pressure,
    required this.max_temp,
    required this.min_temp,
    required this.the_temp,
  });

  @override
  List<Object> get props => [ city, weather_state_name, applicable_date,
    weather_icon, wind_speed, humidity, air_pressure, max_temp,
    min_temp, the_temp ];
}
