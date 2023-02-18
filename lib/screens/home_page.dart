import 'package:flutter/material.dart';

import '../utitls/consts.dart';

class HomePage extends StatefulWidget {
  final weatherData;

  const HomePage({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  num temp = 0;
  int condition = 0;
  String description = 'there is no weather data';
  late String cityName = '';
  late String icon = 'Error';

  void updateUi(var weatherData) {
    setState(() {
      if (weatherData != null) {
        temp = weatherData['main']['temp'];
        condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        description = weatherData.getMessage(temp.toInt());
        icon = weatherData.getWeatherIcon(condition);
      }
    });
  }

  ImageProvider networkImage =
      const NetworkImage('https://source.unsplash.com/random/?cloud');

  ImageProvider assetsImage =
      const AssetImage('images/location_background.jpg');
  bool isLoading = false;

  @override
  void initState() {
    networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      setState(() {
        isLoading = true;
      });
    }));
    super.initState();

    updateUi(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: assetsImage,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop))),
          ),
          AnimatedOpacity(
            curve: Curves.bounceInOut,
            opacity: isLoading ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: networkImage,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.dstATop))),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.near_me,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_city,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      icon,
                      style: kTempTextStyle,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${temp.round()}',
                          style: kTempTextStyle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 10),
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 7,
                              width: 35,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 12,
                                fontFamily: 'Spartan MB',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, bottom: 24),
            child: Text(
              '$description in $cityName',
              textAlign: TextAlign.right,
              style: kMessageTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
