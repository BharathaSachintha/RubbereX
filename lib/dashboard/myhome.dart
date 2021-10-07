import 'dart:async';

import 'package:app/ChatBot/chatbot.dart';
import 'package:app/ChatBot/chatbot_web_view.dart';
import 'package:app/Forcast/models/location.dart';
import 'package:app/Forcast/other/currentWeather.dart';
import 'package:app/Screens/News/news.dart';
import 'package:app/Screens/Profile/profile.dart';
import 'package:app/Screens/TimeTable/timeTable.dart';
import 'package:app/Screens/green/home_page.dart';
import 'package:app/Shopping/home_screen.dart';
import 'package:app/dashboard/bar_icon.dart';
import 'package:app/dashboard/home_icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String latx = "10";
  String lngx = "20";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        color: Color(0xFFe5e5e5),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bar_Category(
                image: 'https://www.linkpicture.com/q/home-3.png',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
              ),
              Bar_Category(
                image: 'https://www.linkpicture.com/q/settings-4.png',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Transform.rotate(
                //   origin: Offset(30, -60),
                //   angle: 2.4,
                //   child: Container(
                //     margin: EdgeInsets.only(
                //       left: 100,
                //       top: 40,
                //     ),
                //     height: 300,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(80),
                //         gradient: LinearGradient(
                //             begin: Alignment.bottomLeft,
                //             colors: [Color(0xFFD88AB), Color(0xFFB1D8B7)])),
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RuBBereX',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Harvest the best crops',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ලාංකීය අපනයන බෝග කලාවේ නවතම මුහුණුවර෴',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Category(
                                  image:
                                      'https://www.linkpicture.com/q/folded-newspaper.png',
                                  text: 'News',
                                  color: Color(0xFFFFFFFF),
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return News();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Category(
                                  image:
                                      'https://www.linkpicture.com/q/cloudy.png',
                                  text: 'Weather',
                                  color: Color(0xFFFFFFFF),
                                  press: () async {
                                    Position position =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.high);
                                    setState(() {
                                      latx = position.latitude.toString();
                                      lngx = position.longitude.toString();
                                    });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          List<Location> locations = [
                                            Location(
                                                city: "Colombo",
                                                country: "Sri Lanka",
                                                lat: latx,
                                                lon: lngx),
                                          ];
                                          return CurrentWeatherPage(
                                              locations, context);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(TimeTable());
                                  },
                                  child: Category(
                                    image:
                                        'https://www.linkpicture.com/q/schedule-1.png',
                                    text: 'TimeTable',
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                Category(
                                  image:
                                      'https://www.linkpicture.com/q/shopping-cart-3.png',
                                  text: 'Shooping',
                                  color: Color(0xFFffffff),
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomeScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => ChatBotWebView(),
                                      ),
                                    );
                                  },
                                  child: Category(
                                    image:
                                        'https://www.linkpicture.com/q/24-hours-1.png',
                                    text: '24/7 Service',
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                Category(
                                  image:
                                      'https://www.linkpicture.com/q/sensor-1_1.png',
                                  text: 'Sensor Data',
                                  color: Color(0xFFffffff),
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomePage();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Image.network(
                              "https://www.linkpicture.com/q/Greenair-cleaning-logo-1_1.png",
                              height: 170,
                              width: 170,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
