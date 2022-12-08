import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/*
Convert Celcius to Farenheit
 */
String toFahrenheit(int temp) {
  double fahrenheit = (temp * 9/5) + 32;
  return fahrenheit.round().toString()+"°F";
}

/*
Get the name of week day from date string
 */
String getDay({String format="EEEE", required String date}) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat(format).format(parsedDate);
  } catch (e) {
    return "nil";
  }
}


