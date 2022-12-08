import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required String city,
    required String weather_state_name,
    required String weather_icon,
    required String applicable_date,
    required int wind_speed,
    required int humidity,
    required int air_pressure,
    required int max_temp,
    required int min_temp,
    required int the_temp,
  }) : super(
      city: city,
      weather_state_name:weather_state_name,
      applicable_date:applicable_date,
      weather_icon:weather_icon,
      wind_speed: wind_speed,
      humidity:humidity,
      air_pressure:air_pressure,
      max_temp:max_temp,
      min_temp:min_temp,the_temp:the_temp
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    //I am using the keys of metaweather because i started with it
    return WeatherModel(
      city: json['location']['name'],
      applicable_date: json['location']['localtime'],
      weather_state_name: json['current']['weather_descriptions'][0],
      weather_icon: json['current']['weather_icons'][0],
      wind_speed: json['current']['wind_speed'],
      humidity: json['current']['humidity'],
      air_pressure: json['current']['pressure'],
      max_temp: json['current']['feelslike'],//TODO weatherstack doesn't return max_temp in free plan
      min_temp: json['current']['temperature'],//TODO weatherstack doesn't return min_temp in free plan
      the_temp: json['current']['temperature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'applicable_date': applicable_date,
      'weather_state_name':weather_state_name,
      'weather_icon': weather_icon,
      'wind_speed': wind_speed,
      'humidity': humidity,
      'air_pressure': air_pressure,
      'max_temp': max_temp,
      'min_temp': min_temp,
      'the_temp': the_temp,
    };
  }


  factory WeatherModel.fromFakeJson(Map<String, dynamic> json) {
    //I am using the keys of metaweather because i started with it
    return WeatherModel(
      city: "Berlin",
      applicable_date: "2022-05-30",
      weather_state_name: "Fake Cloudy",
      weather_icon: "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png",
      wind_speed: 9,
      humidity: 20,
      air_pressure: 1000,
      max_temp: 45,
      min_temp: 38,
      the_temp: 40,
    );
  }

}
