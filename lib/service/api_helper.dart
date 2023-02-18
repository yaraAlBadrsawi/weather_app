import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/service/location.dart';

import '../utitls/consts.dart';

class WeatherAPI {
  Future<dynamic> readData(Location location) async {
    Response response = await get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat='
            '${location.latitude}'
            '&lon=${location.longitude}'
            '&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }
}
