import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/service/location.dart';
import 'package:weather_app/service/api_helper.dart';

import '../model/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  getLocationWeather() async {
    var respone = await Weather().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(weatherData: respone),
      ),
    );
  }

  @override
  void initState() {
    getLocationWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: Colors.blue,
      size: 50.0,
    );
  }
}
