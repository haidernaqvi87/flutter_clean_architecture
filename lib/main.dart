import 'package:flutter/material.dart';
import 'features/weather_update/presentation/pages/weather_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      home: WeatherUpdatePage(),
    );
  }
}
