import 'package:weatherapp/core/util/common.dart';
import 'package:weatherapp/core/util/fonts_and_padding.dart';
import 'package:weatherapp/features/weather_update/domain/entities/weather_entity.dart';
import 'package:weatherapp/features/weather_update/presentation/widgets/image_display.dart';
import 'package:flutter/material.dart';

class WeatherDisplay extends StatefulWidget {
  final List<WeatherEntity> weatherList;

  const WeatherDisplay({
    Key? key,
    required this.weatherList,
  }) : super(key: key);

  @override
  _WeatherDisplayState createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  int selectedIndex = 0;
  bool _isCelsius = true;

  @override
  Widget build(BuildContext context) {
    WeatherEntity weather = widget.weatherList[selectedIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///Week Day
        Center(
          child: Text(
            getDay(date: weather.applicable_date),
            style: TextStyle(fontSize: fontH1(context), fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: sbHeight(context)*2.0,),
        ///Weather condition State
        Text(
          weather.weather_state_name,
          style: TextStyle(fontSize: fontH2(context), fontWeight: FontWeight.w600),
        ),
        SizedBox(height: sbHeight(context),),

        ///Weather condition Image
        ///Weather condition Image
        Center(child: ImageDisplay(imageUrl: weather.weather_icon,)),
        SizedBox(height: sbHeight(context)*2.0,),

        ///Current Temperature
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (_isCelsius) ? '${weather.the_temp}°C' : toFahrenheit(weather.the_temp),
              style: TextStyle(fontSize: fontH1(context), fontWeight: FontWeight.bold),
            ),
            Switch(value: _isCelsius, onChanged: (value) {
              setState(() {
                _isCelsius = value;
              });
            }),
            Text(
              "Celsius",
              style: TextStyle(fontSize: fontH7(context), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: sbHeight(context)*3.0,),
        ///End of current Temperature

        ///Extra information
        _getExtraInfo(label:"Humidity: " ,text: "${weather.humidity}%"),
        SizedBox(height: sbHeight(context),),
        _getExtraInfo(label:"Pressure: " ,text: "${weather.air_pressure} hPa"),
        SizedBox(height: sbHeight(context),),
        _getExtraInfo(label:"Wind: " ,text: "${weather.wind_speed} Km/h"),
        ///End of extra information

        SizedBox(height: sbHeight(context)*4.0,),

        ///List of further days
        Container(
          height: sbHeight(context)*14.0,

          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.weatherList.length,
            itemBuilder: (BuildContext context, int index) {
              WeatherEntity wm = widget.weatherList[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: (selectedIndex == index) ? Colors.blue :
                            Colors.white,
                            width:  2),
                        color: Color(0xfff5f6f8)),
                    margin: EdgeInsets.only(right: pad(context)),
                    width: MediaQuery.of(context).size.width / 3,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            getDay(format: 'EE',date: wm.applicable_date),
                            style: TextStyle(fontSize: fontH5(context),
                                fontWeight: FontWeight.w600),
                          ),
                          ImageDisplay(imageUrl: wm.weather_icon,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (_isCelsius) ? '${wm.min_temp}°C' :
                                toFahrenheit(wm.min_temp),
                                style: TextStyle(fontSize: fontH6(context),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "/",
                                style: TextStyle(fontSize: fontH6(context),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                (_isCelsius) ? '${wm.max_temp}°C' :
                                toFahrenheit(wm.min_temp),
                                style: TextStyle(fontSize: fontH6(context),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              );
            },
          ),
        ),
        SizedBox(height: sbHeight(context)*2.0,),
        ///End of list

      ],
    );
  }


  Row _getExtraInfo({required String label, required String text}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: fontH4(context), fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: TextStyle(fontSize: fontH4(context), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
