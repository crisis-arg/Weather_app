import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/constants.dart';

class Detailpage extends StatefulWidget {
  final List dailyForecastWeather;
  const Detailpage({super.key, required this.dailyForecastWeather});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final Constants _myConst = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int mintemp = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemp = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecasteDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemp': mintemp,
        'maxTemp': maxTemp,
      };
      return forecastData;
    }

    setState(() {
      print(getForecastWeather(0)['forecasteDate']);
    });

    return Scaffold(
      backgroundColor: _myConst.primaryColor,
      appBar: AppBar(
        backgroundColor: _myConst.primaryColor,
        title: Text(
          'Forecasts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            // left: 0,
            child: Container(
              height: size.height * 0.75,
              width: size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
                color: Colors.white,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: size.height * 0.38,
                      width: size.width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            Color(0xffa9c1f5),
                            Color(0xff6696f5),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 3,
                            spreadRadius: -10,
                            offset: const Offset(0, 25),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -30,
                            left: 10,
                            child: Image.asset(
                              "assets/" + getForecastWeather(0)['weatherIcon'],
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                getForecastWeather(0)['weatherName'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 20,
                            child: Container(
                              width: size.width * 0.8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)['maxWindSpeed'],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)['avgHumidity'],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)['chanceOfRain'],
                                    unit: "%",
                                    imageUrl: "assets/cloud.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    getForecastWeather(0)['minTemp'].toString(),
                                    style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = _myConst.shader,
                                    ),
                                  ),
                                ),
                                Text(
                                  "o",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _myConst.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.35,
                    // bottom: size.height / 0.4,
                    right: 20,
                    left: 20,
                    child: SizedBox(
                      height: size.height * .4,
                      // width: size.width * 0.9,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: weatherData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3.0,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getForecastWeather(
                                            index)["forecasteDate"],
                                        style: const TextStyle(
                                          color: Color(0xff6696f5),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${getForecastWeather(index)['minTemp']}° ",
                                                style: TextStyle(
                                                  color: _myConst.greyColor,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${getForecastWeather(index)['maxTemp']}°",
                                                style: TextStyle(
                                                  color: _myConst.primaryColor
                                                      .withOpacity(0.45),
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/' +
                                                getForecastWeather(
                                                    index)["weatherIcon"],
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            getForecastWeather(
                                                index)["weatherName"],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            getForecastWeather(
                                                        index)["chanceOfRain"]
                                                    .toString() +
                                                "%",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            'assets/lightrain.png',
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
