import 'package:weatherapp/core/util/fonts_and_padding.dart';
import 'package:weatherapp/features/weather_update/presentation/bloc/bloc.dart';
import 'package:weatherapp/features/weather_update/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weatherapp/injection_container.dart';

class WeatherUpdatePage extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Updates'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<WeatherBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WeatherBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: sbHeight(context)),
            WeatherControls(),
            SizedBox(height: sbHeight(context)*2.0),
            Expanded(child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                    message: 'Start searching!',
                  );
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return SmartRefresher(
                      controller: _refreshController,
                      onRefresh: () {
                        BlocProvider.of<WeatherBloc>(context).add(GetWeather(state.inputStr));
                        _refreshController.loadComplete();
                      },
                      child: SingleChildScrollView(child: WeatherDisplay(weatherList: state.weather)));
                } else if (state is Error) {
                  return Column(
                    children: [
                      MessageDisplay(
                        message: state.message,
                      ),
                      Visibility(
                        visible: state.message == SERVER_FAILURE_MESSAGE || state.message == INTERNET_FAILURE_MESSAGE,
                        child: ElevatedButton(onPressed: (){
                          BlocProvider.of<WeatherBloc>(context).add(GetWeather(state.inputStr));
                        }, child: Text("Retry")),
                      ),
                    ],
                  );
                }
                return MessageDisplay(
                  message: 'Start searching!',
                );
              },
            ),),
            // Bottom half
          ],
        ),
      ),
    );
  }

}
