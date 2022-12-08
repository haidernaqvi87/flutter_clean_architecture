import 'package:weatherapp/core/util/fonts_and_padding.dart';
import 'package:weatherapp/features/weather_update/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherControls extends StatefulWidget {
  const WeatherControls({
    Key? key,
  }) : super(key: key);

  @override
  _WeatherControlsState createState() => _WeatherControlsState();
}

class _WeatherControlsState extends State<WeatherControls> {
  final controller = TextEditingController();
  String inputStr = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sbHeight(context)*4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: TextField(
              inputFormatters:[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))],
              controller: controller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter city',
            ),
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) {
              _dispatchWeather();
            },
          ),),
          SizedBox(width: sbHeight(context),),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              child: Text('Search'),
              style: ButtonStyle(
                //color: Theme.of(context).accentColor,
                //textTheme: ButtonTextTheme.primary,
              ),
              onPressed: _dispatchWeather,
            ),
          ),
        ],
      ),
    );
  }

  void _dispatchWeather() {
    BlocProvider.of<WeatherBloc>(context).add(GetWeather(inputStr));
  }

}
