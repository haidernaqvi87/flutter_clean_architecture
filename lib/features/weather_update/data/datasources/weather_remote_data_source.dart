import 'dart:convert';
import 'package:weatherapp/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/core/error/exceptions.dart';
import 'package:weatherapp/features/weather_update/data/models/weather_model.dart';


abstract class WeatherRemoteDataSource {
  /// Calls the FORECAST_API_URL/{city} endpoint.
  ///
  /// Throws a [ServerException] or [DataException] for error codes.
  Future<List<WeatherModel>> getCityWeather(String city);

}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WeatherModel>> getCityWeather(String city) async {
    print(FORECAST_API_URL+'?access_key='+FORECAST_API_KEY+'&query=$city');
    final response = await client.get(
      Uri.parse(FORECAST_API_URL+'?access_key='+FORECAST_API_KEY+'&query=$city'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 ) {
        print(response.body.toString());

        dynamic responseJson = json.decode(response.body);
        if (responseJson["error"] == null ) {
          List<WeatherModel> list = [];
          list.add(WeatherModel.fromJson(responseJson));

          ///Because weatherstack doesn't return list of forecast for next days
          ///therefore just for the sack of testing i am delebrately adding
          ///another fake day forcast so that list item clicking functionality
          ///could be tested
          list.add(WeatherModel.fromFakeJson(json.decode(response.body)));
          list.add(WeatherModel.fromFakeJson(json.decode(response.body)));
          list.add(WeatherModel.fromFakeJson(json.decode(response.body)));
          return list;
        } else {
          throw DataException();
        }
      } else {
        throw ServerException();
      }
  }

}
