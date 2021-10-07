import 'package:app/Screens/green/green_plant.dart';
import 'package:app/Screens/green/other_item.dart';
import 'package:app/Screens/green/shop_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgets = [
    GreenPlant(),
    ShopItem(),
    OtherItem(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Row(
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.symmetric(vertical: 35),
            color: Theme.of(context).primaryColor,
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  Spacer(),
                  buildMenuItem("Green Plant", 0),
                  buildMenuItem("Knife", 1),
                  buildMenuItem("Other", 2),
                  Spacer(),
                  RotatedBox(
                      quarterTurns: -1,
                      child: IconButton(
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {})),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: PageView(
              children: [
                widgets[currentIndex],
              ],
            ),
          )),
        ],
      ),
    );
  }

  TextButton buildMenuItem(String title, int index) {
    bool isSelected = currentIndex == index;
    return TextButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSelected
              ? Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                )
              : Container(height: 10),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: isSelected ? 20 : 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
      onPressed: () => setState(() => currentIndex = index),
    );
  }
}
