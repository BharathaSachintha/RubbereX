import 'package:app/Forcast/models/forecast.dart';
import 'package:app/Forcast/models/location.dart';
import 'package:app/Forcast/models/weather.dart';
import 'package:app/Forcast/other/weatherController.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'extenaions.dart';
import 'package:lottie/lottie.dart';

class CurrentWeatherPage extends StatefulWidget {
  final List<Location> locations;
  final BuildContext context;
  const CurrentWeatherPage(this.locations, this.context);

  @override
  _CurrentWeatherPageState createState() =>
      _CurrentWeatherPageState(this.locations, this.context);
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final List<Location> locations;
  final Location location;
  final BuildContext context;
  _CurrentWeatherPageState(List<Location> locations, BuildContext context)
      : this.locations = locations,
        this.context = context,
        this.location = locations[0];

  final weatherController wc = Get.put(weatherController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get.defaultDialog();
    Future.delayed(Duration(seconds: 10), () {
      // 5s over, navigate to a new page
      Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              if(wc.have.value == true)
              Text(
                "We recommand " +
                    wc.finalBestStartTime.toString() +
                    " to " +
                    wc.finalBestEndTime.toString() +
                    " time you to cut rubber latex.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              if(wc.have.value == false)
              Text(
                "Today no any proper time to curt rubber latex.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(children: <Widget>[
          currentWeatherViews(this.locations, this.location, this.context),
          forcastViewsHourly(this.location),
          forcastViewsDaily(this.location),
        ]));
  }
}

Widget currentWeatherViews(
    List<Location> locations, Location location, BuildContext context) {
  Weather _weather;
  final weatherController wc = Get.put(weatherController());

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _weather = snapshot.data;
        if (_weather == null) {
          return Text("Error getting weather");
        } else {
          return Column(children: [
            createAppBar(locations, location, context),
            weatherBox(_weather),
            weatherDetailsBox(_weather),
          ]);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getCurrentWeather(location),
  );
}

Widget forcastViewsHourly(Location location) {
  Forecast _forcast;
  final weatherController wc = Get.put(weatherController());

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data;
        if (_forcast == null) {
          return Text("Error getting weather");
        } else {
          return hourlyBoxes(_forcast);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

Widget forcastViewsDaily(Location location) {
  Forecast _forcast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data;
        if (_forcast == null) {
          return Text("Error getting weather");
        } else {
          return dailyBoxes(_forcast);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

Widget createAppBar(
    List<Location> locations, Location location, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "With Your Current Location ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 38.0,
            width: 38.0,
            child: Lottie.asset("assets/waiting.json"),
          ),
        ],
      )),
    ),
  );
}

Widget weatherDetailsBox(Weather _weather) {
  return Container(
    padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
    margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]),
    child: Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Container(
                child: Text(
              "Wind",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            )),
            Container(
                child: Text(
              "${_weather.wind} km/h",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            ))
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Container(
                child: Text(
              "Humidity",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            )),
            Container(
                child: Text(
              "${_weather.humidity.toInt()}%",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            ))
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Container(
                child: Text(
              "Pressure",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            )),
            Container(
                child: Text(
              "${_weather.pressure} hPa",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            ))
          ],
        ))
      ],
    ),
  );
}

Widget weatherBox(Weather _weather) {
  return Stack(children: [
    Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(15.0),
      height: 160.0,
      decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
    ClipPath(
        clipper: Clipper(),
        child: Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            height: 160.0,
            decoration: BoxDecoration(
                color: Colors.indigoAccent[400],
                borderRadius: BorderRadius.all(Radius.circular(20))))),
    Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 160.0,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  getWeatherIcon(_weather.icon),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        "${_weather.description.capitalizeFirstOfEach}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.white),
                      )),
                ])),
            Column(children: <Widget>[
              Container(
                  child: Text(
                "${_weather.temp.toInt()}°",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Colors.white),
              )),
              Container(
                  margin: const EdgeInsets.all(0),
                  child: Text(
                    "Feels like ${_weather.feelsLike.toInt()}°",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.white),
                  )),
            ])
          ],
        ))
  ]);
}

Image getWeatherIcon(String _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 70,
    height: 70,
  );
}

Image getWeatherIconSmall(String _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 40,
    height: 40,
  );
}

Widget hourlyBoxes(Forecast _forecast) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      height: 150.0,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
          scrollDirection: Axis.horizontal,
          itemCount: _forecast.hourly.length,
          itemBuilder: (BuildContext context, int index) {
            String startingTime = _forecast.hourly[0].dt.toString();
            String endingTime = _forecast.hourly[16].dt.toString();
            int yes = 0;
            int no = 0;
            String bestStartTime = 'no bestStartTime';
            String bestEndTime = 'no bestEndTime';

            if (getTimeFromTimestamp(
                            int.parse(_forecast.hourly[index].dt.toString()))
                        .toString() ==
                    '12:30 AM' &&
                index < 20) {
              String stx = _forecast.hourly[index].dt.toString();
              for (int i = index; i <= index + 7; i++) {
                print(
                    i.toString() + _forecast.hourly[i].description.toString());
                if (_forecast.hourly[i].description.toString() ==
                    "overcast clouds") {
                  yes = yes + 1;
                  bestStartTime = _forecast.hourly[i - (yes - 1)].dt.toString();
                  print("inside start " +
                      getTimeFromTimestamp(int.parse(bestStartTime))
                          .toString());
                  bestEndTime = _forecast.hourly[i].dt.toString();
                  print("inside end " +
                      getTimeFromTimestamp(int.parse(bestEndTime)).toString());
                  final weatherController wc = Get.put(weatherController());
                  wc.finalBestEndTime.value =
                      getTimeFromTimestamp(int.parse(bestEndTime)).toString();
                  wc.finalBestStartTime.value =
                      getTimeFromTimestamp(int.parse(bestStartTime)).toString();
                } else {
                  no = no + 1;
                }
              }
              print(bestStartTime);
              print(bestEndTime);
              print("num of yes " + yes.toString());
              print("num of no " + no.toString());
              if (bestStartTime == 'no bestStartTime' ||
                  bestEndTime == 'no bestEndTime') {
                print("no proper time today to cut rubber latex...");
                final weatherController wc = Get.put(weatherController());
                wc.have.value = false;
                
              } else {
                print(getTimeFromTimestamp(int.parse(bestStartTime))
                        .toString() +
                    ' to ' +
                    getTimeFromTimestamp(int.parse(bestEndTime)).toString() +
                    ' time is best to cut rubber latex');
                    final weatherController wc = Get.put(weatherController());
                wc.have.value = true;
              }
            }

            return Container(
                padding: const EdgeInsets.only(
                    left: 10, top: 15, bottom: 15, right: 10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      )
                    ]),
                child: Column(children: [
                  // Text(index.toString()),
                  Text(
                    "${_forecast.hourly[index].temp}°",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  getWeatherIcon(_forecast.hourly[index].icon),
                  Text(
                    "${getTimeFromTimestamp(_forecast.hourly[index].dt)}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ]));
            return Text("Nothing");
          }));
}

String getTimeFromTimestamp(int timestamp) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('h:mm a');
  return formatter.format(date);
}

String getDateFromTimestamp(int timestamp) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('E');
  return formatter.format(date);
}

Widget dailyBoxes(Forecast _forcast) {
  return Row(
    children: [
      Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding:
                  const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
              itemCount: _forcast.daily.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 10),
                    margin: const EdgeInsets.all(5),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        "${getDateFromTimestamp(_forcast.daily[index].dt)}",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                      Expanded(
                          child:
                              getWeatherIconSmall(_forcast.daily[index].icon)),
                      Expanded(
                          child: Text(
                        "${_forcast.daily[index].high.toInt()}/${_forcast.daily[index].low.toInt()}",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )),
                    ]));
              })),
    ],
  );
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        size.width, size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

Future getCurrentWeather(Location location) async {
  Weather weather;
  String city = location.city;
  String apiKey = "67987fa9045fb45fbe2b0e3ad43dfdf8";
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {}
  return weather;
}

Future getForecast(Location location) async {
  Forecast forecast;
  String apiKey = "67987fa9045fb45fbe2b0e3ad43dfdf8";
  String lat = location.lat;
  String lon = location.lon;
  // String lat = 8.toString();
  // String lon = 80.toString();
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  }

  return forecast;
}
